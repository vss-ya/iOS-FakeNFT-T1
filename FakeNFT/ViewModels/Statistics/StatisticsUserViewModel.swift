//
//  StatisticsUserViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsUserViewModel: StatisticsUserViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    private let user: StatisticsUser
    
    var updateData: Binding<StatisticsUser>?
    
    init(at indexPath: IndexPath) {
        self.user = dataStore.users[indexPath.row]
    }
    
    func getUser() -> StatisticsUser {
        return user
    }
}
