//
//  CatalogViewModel.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

protocol CatalogViewModelProtocol {
    var updateData: Binding<Bool>? { get set }
    
    func getData()
    func getCollectionsNumber() -> Int
    func collection(at inadexPath: IndexPath) -> Catalog
    func sortByName()
    func sortByNftCount()
}


final class CatalogViewModel: CatalogViewModelProtocol {
    
    private let mokCatalog = MokCatalog.shared
    private let dataStore = CatalogDataStore.shared
    
    var updateData: Binding<Bool>?
    
    func getCollectionsNumber() -> Int {
        dataStore.catalog.count
    }
    
    func getData() {
        dataStore.getCatalog { [weak self] result in
            guard let self = self else { return }
            self.updateData?(result)
        }
    }
    
    func collection(at indexPath: IndexPath) -> Catalog {
        dataStore.catalog[indexPath.row]   
    }

    
    func sortByName() {
        dataStore.catalog.sort(by: { $0.name < $1.name })
    }
    
    func sortByNftCount() {
        dataStore.catalog.sort { $0.nfts.count > $1.nfts.count }
    }


}
