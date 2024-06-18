//
//  StatisticsViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsViewModel: StatisticsCollectionsViewModelProtocol {
    let profiles: [StatisticsUser] = [
        StatisticsUser(
            name: "Alex",
            avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
            description: "Дизайнер из Казани, люблю цифровое искусство  и бейглы. В моей коллекции уже 100+ NFT,  и еще больше — на моём сайте. Открыт  к коллаборациям.",
            website: "https://practicum.yandex.ru/ios-developer",
            nfts: ["", "", ""],
            rating: "1",
            id: "1"
        ),
        StatisticsUser(
            name: "Bill",
            avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
            description: "Описание Била",
            website: "https://yandex.ru",
            nfts: ["", "", "", "", "", ""],
            rating: "2",
            id: "2"
        ),
        StatisticsUser(
            name: "Alla",
            avatar: "",
            description: "Описание Аллы",
            website: "https://figma.com",
            nfts: ["", "", "", "", ""],
            rating: "3",
            id: "3"
        ),
        StatisticsUser(
            name: "Mads",
            avatar: "https://code.s3.yandex.net/landings-v2-ios-developer/space.PNG",
            description: "Описание Мэда",
            website: "https://practicum.yandex.ru/",
            nfts: ["", "", "", ""],
            rating: "4",
            id: "4"
        )
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
