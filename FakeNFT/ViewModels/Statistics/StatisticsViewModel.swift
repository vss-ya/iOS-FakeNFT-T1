//
//  StatisticsViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsViewModel: StatisticsViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    
    private var users: [StatisticsUser] = []
    
    var numberOfSections: Int {
        return 1
    }
    
    func getData(sortField: StatisticsSortFields) {
        dataStore.getUsers(sortField: sortField) { [weak self] users in
            guard let self = self else { return }
            self.users = users
            self.updateData?(!users.isEmpty)
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return users.count
    }
    
    func model(at indexPath: IndexPath) -> Decodable {
        return users[indexPath.row]
    }
}
