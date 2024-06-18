//
//  StatisticsViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsViewModel: StatisticsCollectionsViewModelProtocol {
    let profiles: [StatisticsProfile] = [
        StatisticsProfile(name: "Alex", avatar: "", description: "Описание Алекса", website: "https://ya.ru", nfts: [], likes: [], id: "1"),
        StatisticsProfile(name: "Bill", avatar: "", description: "Описание Била", website: "https://yandex.ru", nfts: [], likes: [], id: "2"),
        StatisticsProfile(name: "Alla", avatar: "", description: "Описание Аллы", website: "https://figma.com", nfts: [], likes: [], id: "3"),
        StatisticsProfile(name: "Mads", avatar: "", description: "Описание Мэда", website: "https://practicum.yandex.ru/", nfts: [], likes: [], id: "4")
    ]
    
    var updateData: Binding<Bool>?
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return profiles.count
    }
    
    func model(at indexPath: IndexPath) -> Decodable {
        return profiles[indexPath.row]
    }
    
    func initialize() {
        updateData?(true)
    }
}