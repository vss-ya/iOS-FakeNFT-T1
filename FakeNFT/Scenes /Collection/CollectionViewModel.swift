//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

protocol CollectionViewModelProtocol: AnyObject {
    var updateCollection: Binding<Bool>? { get set }
    var nftNumber: Int { get }
    func getSelectedCollection() -> Catalog?
    func getData()
    func getNft(at indexPath: IndexPath) -> CatalogNft
    func isLiked(_ nft: String) -> Bool
    func inCart(_ nft: String) -> Bool
    func didTapLike(_ nft: String)
    func didTapCart(_ nft: String)
    
}

final class CollectionViewModel: CollectionViewModelProtocol {
    
    var updateCollection: Binding<Bool>?
    var nftNumber: Int = 0
    
    private let dataStore = CatalogDataStore.shared
    private (set) var selectedCollection: String
    
    init(updateCollection: Binding<Bool>? = nil, selectedCollection: String) {
        self.updateCollection = updateCollection
        self.selectedCollection = selectedCollection
    }
    
    func getSelectedCollection() -> Catalog? {
        dataStore.getCollection(with: selectedCollection)
    }
    
    func getData() {
        dataStore.getNft(with: selectedCollection) { [weak self] result in
            guard let self = self else { return }
            self.updateCollection?(result)
            nftNumber = dataStore.collection.count
            dataStore.getUserProfile()
            dataStore.getUserCart()
        }
    }
    
    func getNft(at indexPath: IndexPath) -> CatalogNft {
        return  dataStore.collection[indexPath.row]
    }
    
    func isLiked(_ nft: String) -> Bool {
        var isLiked: Bool = false
        if let userLikes = dataStore.userProfile?.likes {
            isLiked = userLikes.contains(nft)
        }
        return isLiked
    }
    
    func didTapLike(_ nft: String) {
        dataStore.updateLike(nft)
    }
    
    func inCart(_ nft: String) -> Bool {
        var inCart: Bool = false
        if let userCart = dataStore.userCart {
            inCart = userCart.nfts.contains(nft)
        }
        return inCart
    }
    
    func didTapCart(_ nft: String) {
        dataStore.updateCart(nft)
    }
    
    
}
