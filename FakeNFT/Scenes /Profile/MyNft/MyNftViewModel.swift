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
    func like(nft: Nft, _ isLiked: Bool)
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
            switch result {
            case .success(let profile):
                self?.profile = profile
                self?.loadNfts()
            case .failure(let error):
                self?.onDidLoadWithError?(error)
            }
        }
    }

    func sort(_ filter: ProfileNftFilter) {
        self.filter = filter
        load()
    }

    func update(_ profile: Profile) {
        profileService.updateProfile(profile) { [weak self](result) in
            switch result {
            case .success(let profile):
                self?.profile = profile
                self?.loadNfts()
            case .failure(let error):
                self?.onDidLoadWithError?(error)
            }
        }
    }

    func like(nft: Nft, _ isLiked: Bool) {
        guard let profile = profile else {
            let error = NSError(domain: "Missed profile", code: 0)
            onDidLoadWithError?(error)
            return
        }
        let nftIds = isLiked ? Array(Set(profile.likes).union([nft.id])) : profile.likes.filter({ $0 != nft.id })

        let updatedProfile = Profile(
            id: profile.id,
            name: profile.name,
            avatar: profile.avatar,
            description: profile.description,
            website: profile.website,
            nfts: profile.nfts,
            likes: nftIds
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
        guard !nftIds.isEmpty else {
            self.nfts = nfts
            self.onDidLoad?(nfts)
            return
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
                    print("Failed to load NFTs: \(error)")
                }
            }
        }
        dg.notify(queue: .global()) { [weak self] in
            guard let self = self else { return }
            switch self.filter {
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
