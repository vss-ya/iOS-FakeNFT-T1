//
//  StatisticsUserViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsUserViewModel: StatisticsUserViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    private let id: String
    
    var updateData: Binding<StatisticsUser>?
    
    init(id: String) {
        self.id = id
    }
    
    func getUser() {
        dataStore.getUser(id: id) { [weak self] user in
            guard let user else { return }
            self?.updateData?(user)
        }
    }
}
