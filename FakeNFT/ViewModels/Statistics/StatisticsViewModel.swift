//
//  StatisticsViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsViewModel: StatisticsCollectionsViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    var numberOfSections: Int {
        return 1
    }
    
    func getData(sortField: StatisticsSortFields) {
        dataStore.getUsers(sortField: sortField) { [weak self] result in
            self?.updateData?(result)
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return dataStore.users.count
    }
    
    func model(at indexPath: IndexPath) -> Decodable {
        return dataStore.users[indexPath.row]
    }
}
