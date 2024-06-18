//
//  StatisticsViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsViewModel: StatisticsCollectionsViewModelProtocol {
    let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return dataStore.users.count
    }
    
    func model(at indexPath: IndexPath) -> Decodable {
        return dataStore.users[indexPath.row]
    }
    
    func initialize() {
        updateData?(true)
    }
}
