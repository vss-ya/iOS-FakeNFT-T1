//
//  StatisticsUserCollectionViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

final class StatisticsUserCollectionViewModel: StatisticsCollectionsViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    var numberOfSections: Int {
        return 1
    }
    
    func getData(sortField: StatisticsSortFields) {
    
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return dataStore.nfts.count
    }
    
    func model(at indexPath: IndexPath) -> any Decodable {
        return dataStore.nfts[indexPath.row]
    }
}
