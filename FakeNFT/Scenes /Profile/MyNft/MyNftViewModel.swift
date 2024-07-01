//
//  MyNftViewModel.swift
//  FakeNFT
//
//  Created by vs on 25.06.2024.
//

import Foundation

protocol MyNftViewModelProtocol: AnyObject {
    typealias Binding<T> = (T) -> Void
    
    var servicesAssembly: ServicesAssembly { get }
    
    var profile: Profile? { get }
    var nfts: [Nft] { get }
    var filter: ProfileNftFilter { get }
    
    var onDidLoad: Binding<[Nft]>? { get set }
    var onDidLoadWithError: Binding<Error>? { get set }
    
    init(_ servicesAssembly: ServicesAssembly)
    
    func load()
    func sort(_ filter: ProfileNftFilter)
    func like(nft: Nft)
    func dislike(nft: Nft)
    func isLiked(nft: Nft) -> Bool
    
}

final class MyNftViewModel: MyNftViewModelProtocol {
    
    let servicesAssembly: ServicesAssembly
    
    private var profileService: ProfileService { servicesAssembly.profileService }
    private var nftService: NftService { servicesAssembly.nftService }
    
    private(set) var profile: Profile?
    private(set) var nfts: [Nft] = []
    private(set) var filter: ProfileNftFilter {
        get { ProfileSettingsStorage.shared.nftFilter }
        set { ProfileSettingsStorage.shared.nftFilter = newValue }
    }
    
    var onDidLoad: Binding<[Nft]>?
    var onDidLoadWithError: Binding<Error>?
    var onDidUpdate: Binding<Profile>?
    var onDidUpdateWithError: Binding<Error>?
    
    init(_ servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func load() {
        profileService.loadProfile { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.loadNfts()
                case .failure(let error):
                    self?.onDidLoadWithError?(error)
                }
            }
        }
    }
    
    func sort(_ filter: ProfileNftFilter) {
        self.filter = filter
        load()
    }
    
    func update(_ profile: Profile) {
        profileService.updateProfile(profile) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.loadNfts()
                case .failure(let error):
                    self?.onDidLoadWithError?(error)
                }
            }
        }
    }
    
    func like(nft: Nft) {
        guard let profile else {
            return
        }
        let updatedProfile = Profile(
            id: profile.id,
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: Array(Set(profile.likes).union([nft.id]))
        )
        update(updatedProfile)
    }
    
    func dislike(nft: Nft) {
        guard let profile else {
            return
        }
        let updatedProfile = Profile(
            id: profile.id,
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: profile.likes.filter({ $0 != nft.id })
        )
        update(updatedProfile)
    }
    
    func isLiked(nft: Nft) -> Bool {
        let likes = profile?.likes ?? []
        let isLiked = likes.contains(where: { $0 == nft.id })
        return isLiked
    }
    
    private func loadNfts() {
        let dg = DispatchGroup()
        var nfts = [Nft]()
        let nftIds = profile?.nfts ?? []
        if nftIds.isEmpty {
            self.nfts = nfts
            self.onDidLoad?(nfts)
        }
        for id in nftIds {
            dg.enter()
            nftService.loadNft(id: id) {
                defer {
                    dg.leave()
                }
                switch $0 {
                case .success(let nft):
                    nfts.append(nft)
                case .failure(let error):
                    print("Failed to fetch NFTs: \(error)")
                }
            }
        }
        dg.notify(queue: .global()) { [weak self] in
            guard let self else { return }
            switch filter {
            case .byPrice: nfts.sort(by: { $0.price < $1.price })
            case .byRaiting: nfts.sort(by: { $0.rating > $1.rating })
            case .byName: nfts.sort(by: { $0.name < $1.name })
            }
            DispatchQueue.main.async {
                self.nfts = nfts
                self.onDidLoad?(nfts)
            }
        }
    }
    
}
