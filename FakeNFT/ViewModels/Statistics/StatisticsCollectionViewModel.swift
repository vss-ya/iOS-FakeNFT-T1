//
//  StatisticsCollectionViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

final class StatisticsCollectionViewModel: StatisticsCollectionsViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return 7
    }
    
    func model(at indexPath: IndexPath) -> any Decodable {
        return dataStore.users[indexPath.row]
    }
}
