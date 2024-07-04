//
//  CatalogDataStore.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 24.06.2024.
//

import Foundation

protocol CatalogDataStoreProtocol {
    var catalog: [Catalog] { get set }
    func getCatalog(completion: @escaping (Bool) -> Void)
    func getCollection(with id: String) -> Catalog?
    func getCollectionNft(with nfts: [String], completion: @escaping (Bool) -> Void)
}

final class CatalogDataStore {
    
    static let shared = CatalogDataStore()
    private init() {}
    
    var catalog: [Catalog] = []
    var collection: [Nft] = []
    var userProfile: UserProfile?
    var userCart: CatalogCart?
    
    private var task: NetworkTask?
    private var likes: [String] = []
    private var cart: [String] = []
    private let networkClient = DefaultNetworkClient()

    func getCatalog(completion: @escaping (Bool) -> Void) {
        UIBlockingProgressHUD.show()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if self.task != nil { return }
            task?.cancel()
            let request = CatalogRequest()
            self.catalog = []
            self.task = networkClient.send(
                request: request,
                type: [Catalog].self) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let catalog):
                        self.catalog = catalog
                        completion(true)
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(false)
                    }
                    self.task = nil
                    UIBlockingProgressHUD.dismiss()
                }
        }
    }
    
    func getCollection(with id: String) -> Catalog? {
        let selectedCatalog = catalog.first(where: { catalog in
            catalog.id == id })
        return selectedCatalog
    }
    
    func getNft(with id: String, completion: @escaping (Bool) -> Void) {
        let selectedCatalog = catalog.first(where: { catalog in
            catalog.id == id })
        guard let nfts = selectedCatalog?.nfts else { return }
        UIBlockingProgressHUD.show()
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            task?.cancel()
            nfts.forEach { nft in
                let request = CatalogNftRequest(id: nft)
                self.collection = []
                self.task = self.networkClient.send(
                    request: request,
                    type: Nft.self) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case .success(let nft):
                            self.collection.append(nft)
                        case .failure(let error):
                            print(error.localizedDescription)
                            completion(false)
                        }
                        
                        if self.collection.count == nfts.count {
                            completion(true)
                        }
                        
                        self.task = nil
                    }
            }
        }
    }
    
    func getUserProfile() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            task?.cancel()
            let request = CatalogUserProfileRequest()
            self.task = self.networkClient.send(
                request: request,
                type: UserProfile.self) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let userProfile):
                        self.userProfile = userProfile
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    self.task = nil
                }
        }
    }
    
    func updateLike(_ nft: String) {
        if let user = userProfile {
            likes = user.likes
            let isLiked = likes.contains(nft)
            switch isLiked {
            case true: likes = likes.filter { $0 != nft}
            case false: likes.append(nft)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            task?.cancel()
            let dataString = "likes=\(likes.joined(separator: ", "))"
            guard let data = dataString.data(using: .utf8) else { return }
            let request = CatalogProfileUpdateLikes(httpBody: data)
            task = networkClient.send(request: request,
                                      type: UserProfile.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_): getUserProfile()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.task = nil
            }
        }
    }
    
    func getUserCart() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            task?.cancel()
            let request = CatalogCartRequest()
            self.task = self.networkClient.send(
                request: request,
                type: CatalogCart.self) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let userCart):
                        self.userCart = userCart
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    self.task = nil
                }
        }
    }
    
    func updateCart(_ nft: String) {
        if let userCart = userCart?.nfts {
            cart = userCart
            let inCart = cart.contains(nft)
            switch inCart {
            case true: cart = cart.filter { $0 != nft }
            case false: cart.append(nft)
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            task?.cancel()
            let dataString = "nfts=\(cart.joined(separator: ", "))"
            guard let data = dataString.data(using: .utf8) else { return }
            let request = CatalogCartUpdate(httpBody: data)
            task = networkClient.send(request: request,
                                      type: CatalogCart.self) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(_): getUserCart()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self.task = nil
            }
        }
    }
    
}

