//
//  FavoritesNftViewModel.swift
//  FakeNFT
//
//  Created by vs on 25.06.2024.
//

import Foundation

protocol FavoritesNftViewModelProtocol: AnyObject {
    typealias Binding<T> = (T) -> Void
    
    var servicesAssembly: ServicesAssembly { get }
    
    var profile: Profile? { get }
    var nfts: [Nft] { get }
    
    var onDidLoad: Binding<[Nft]>? { get set }
    var onDidLoadWithError: Binding<Error>? { get set }
    
    init(_ servicesAssembly: ServicesAssembly)
    
    func load()
    func dislike(nft: Nft)
    
}

final class FavoritesNftViewModel: FavoritesNftViewModelProtocol {
    
    let servicesAssembly: ServicesAssembly
    
    private var profileService: ProfileService { servicesAssembly.profileService }
    private var nftService: NftService { servicesAssembly.nftService }
    
    private(set) var profile: Profile?
    private(set) var nfts: [Nft] = []
    
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
    
    private func loadNfts() {
        let dg = DispatchGroup()
        var nfts = [Nft]()
        let likes = profile?.likes ?? []
        if likes.isEmpty {
            self.nfts = nfts
            self.onDidLoad?(nfts)
        }
        for id in profile?.likes ?? [] {
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
            nfts.sort(by: { $0.rating > $1.rating })
            DispatchQueue.main.async {
                self?.nfts = nfts
                self?.onDidLoad?(nfts)
            }
        }
    }
    
}
