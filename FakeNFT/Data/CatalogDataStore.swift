//
//  CatalogDataStore.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 24.06.2024.
//

import Foundation

protocol CatalogDataStoreProtocol {
    func getCatalog(completion: @escaping (Bool) -> Void)
}

final class CatalogDataStore: CatalogDataStoreProtocol {
    
    static let shared = CatalogDataStore()
    private init() {}
    
    private var catalogTask: NetworkTask?

    var catalog: [Catalog] = []
    
    func getCatalog(completion: @escaping (Bool) -> Void) {
        UIBlockingProgressHUD.show()
        if catalogTask != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = CatalogRequest()
        catalog = []
        catalogTask = networkClient.send(
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
                self.catalogTask = nil
                UIBlockingProgressHUD.dismiss()
            }
    }
    
    func getCollection(with id: String) -> Catalog? {
        let selectedCatalog = catalog.first(where: { catalog in
            catalog.id == id })
        return selectedCatalog
        }
    
    
}
