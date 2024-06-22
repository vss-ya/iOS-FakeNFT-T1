//
//  StatisticsDataStore.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsDataStore {
    static let shared = StatisticsDataStore()
    
    let users: [StatisticsUser] = [
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
    
    let nfts: [StatisticsNft] = [
        StatisticsNft(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Archie",
            images: [""],
            rating: 2,
            description: "Описание NFT",
            price: 1.78,
            author: "author",
            id: "1"
        ),
        StatisticsNft(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Emma",
            images: [""],
            rating: 4,
            description: "Описание NFT",
            price: 1.25,
            author: "author",
            id: "2"
        ),
        StatisticsNft(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Stella",
            images: [""],
            rating: 5,
            description: "Описание NFT",
            price: 1.82,
            author: "author",
            id: "3"
        ),
        StatisticsNft(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Toasr",
            images: [""],
            rating: 3,
            description: "Описание NFT",
            price: 1.78,
            author: "author",
            id: "4"
        ),
        StatisticsNft(
            createdAt: "2023-04-20T02:22:27Z",
            name: "Zeus",
            images: [""],
            rating: 1,
            description: "Описание NFT",
            price: 1.13,
            author: "author",
            id: "5"
        )
    ]
    
    private init() {}
}
