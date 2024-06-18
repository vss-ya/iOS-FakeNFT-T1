//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

protocol CatalogViewModelProtocol {
    func getCollectionsNumber() -> Int
    
}


final class CatalogViewModel: CatalogViewModelProtocol {
    private let mokCatalog = MokCatalog.shared
    
    func getCollectionsNumber() -> Int {
        mokCatalog.collections.count
    }
    
    
}
