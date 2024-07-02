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
    func getNft(at indexPath: IndexPath) -> Nft
    
}

final class CollectionViewModel: CollectionViewModelProtocol {
    
    private let dataStore = CatalogDataStore.shared
    
    var updateCollection: Binding<Bool>?
    var nftNumber: Int = 0
    
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
        }
    }
    
    func getNft(at indexPath: IndexPath) -> Nft {
        return  dataStore.collection[indexPath.row]
    }
    
    
}
