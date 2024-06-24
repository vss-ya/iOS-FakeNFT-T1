//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

protocol CatalogViewModelProtocol {
    func getCollectionsNumber() -> Int
    func getCollections() -> [Catalog]
    func sortByName()
    func sortByNftCount()
}


final class CatalogViewModel: CatalogViewModelProtocol {
    private let mokCatalog = MokCatalog.shared
    
    func getCollectionsNumber() -> Int {
        mokCatalog.collections.count
    }
    
    func getCollections() -> [Catalog] {
        mokCatalog.collections
    }
    
    func sortByName() {
        mokCatalog.collections.sort(by: { $0.name < $1.name })
    }
    
    func sortByNftCount() {
        mokCatalog.collections.sort { $0.nfts.count > $1.nfts.count }
    }
    
    
}
