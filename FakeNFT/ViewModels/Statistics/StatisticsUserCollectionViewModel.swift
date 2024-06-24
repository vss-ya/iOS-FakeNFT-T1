//
//  StatisticsUserCollectionViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

final class StatisticsUserCollectionViewModel: StatisticsUserCollectionViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    private var ids: [String]
    
    var numberOfSections: Int {
        return 1
    }
    
    init(ids: [String]) {
        self.ids = ids
    }
    
    func getData() {
        
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return dataStore.nfts.count
    }
    
    func model(at indexPath: IndexPath) -> any Decodable {
        return dataStore.nfts[indexPath.row]
    }
}
