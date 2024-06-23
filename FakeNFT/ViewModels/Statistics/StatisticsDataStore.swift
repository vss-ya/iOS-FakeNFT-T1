//
//  StatisticsDataStore.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsDataStore {
    static let shared = StatisticsDataStore()
    
    private var taskUsers: NetworkTask?
    
    var users: [StatisticsUser] = []
    
    let nfts: [StatisticsNft] = [
        StatisticsNft(createdAt: "2023-10-08T07:43:22.944Z[GMT]",
                      name: "Rosario Dejesus",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Finn/3.png"],
                      rating: 4,
                      description: "explicari lobortis rutrum evertitur fugit convenire ligula",
                      price: 28.27,
                      author: "https://unruffled_cohen.fakenfts.org/",
                      id: "c14cf3bc-7470-4eec-8a42-5eaa65f4053c"),
        StatisticsNft(createdAt: "2023-07-07T05:50:45.848Z[GMT]",
                      name: "Steph",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Willow/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Willow/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Yellow/Willow/3.png"],
                      rating: 3,
                      description: "accumsan appareat dolor volutpat volutpat class maecenas in affert",
                      price: 3.35,
                      author: "https://hungry_darwin.fakenfts.org/",
                      id: "d6a02bd1-1255-46cd-815b-656174c1d9c0"),
        StatisticsNft(createdAt: "2023-10-20T10:23:01.305Z[GMT]",
                      name: "Kieth Clarke",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Kaydan/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Kaydan/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Kaydan/3.png"],
                      rating: 2,
                      description: "tacimates docendi efficitur tempus non quod cras pellentesque commune",
                      price: 16.95,
                      author: "https://goofy_napier.fakenfts.org/",
                      id: "f380f245-0264-4b42-8e7e-c4486e237504"),
        StatisticsNft(createdAt: "2023-07-01T23:14:47.494Z[GMT]",
                      name: "Jody Rivers",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lark/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lark/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Lark/3.png"],
                      rating: 1,
                      description: "posse honestatis lobortis tritani scelerisque inimicus",
                      price: 49.64,
                      author: "https://dazzling_meninsky.fakenfts.org/",
                      id: "82570704-14ac-4679-9436-050f4a32a8a0"),
        StatisticsNft(createdAt: "2023-07-11T00:08:48.728Z[GMT]",
                      name: "Minnie",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Pink/Lilo/3.png"],
                      rating: 2,
                      description: "mediocritatem interdum eleifend penatibus adipiscing mattis",
                      price: 40.59,
                      author: "https://wonderful_dubinsky.fakenfts.org/",
                      id: "e33e18d5-4fc2-466d-b651-028f78d771b8"),
        StatisticsNft(createdAt: "2023-08-20T05:02:45.672Z[GMT]",
                      name: "Rudolph Short",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Gray/Butter/3.png"],
                      rating: 3,
                      description: "praesent numquam commodo singulis labores dolor intellegat an orci",
                      price: 25.42,
                      author: "https://tender_solomon.fakenfts.org/",
                      id: "9810d484-c3fc-49e8-bc73-f5e602c36b40"),
        StatisticsNft(createdAt: "2023-10-25T05:36:25.64Z[GMT]",
                      name: "Erwin Barron",
                      images: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Oreo/1.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Oreo/2.png",
                               "https://code.s3.yandex.net/Mobile/iOS/NFT/Peach/Oreo/3.png"],
                      rating: 4,
                      description: "definiebas detraxit luctus reque nam adolescens sententiae suavitate",
                      price: 13.61,
                      author: "https://wizardly_borg.fakenfts.org/",
                      id: "49a96d73-d58f-4c01-8ce3-7d6949c980ca")
    ]
    
    private init() {}
    
    func getUsers(sortField: StatisticsSortFields, completion: @escaping (Bool) -> Void) {
        if taskUsers != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = StatisticsUsersRequest(sortField: sortField)
        users = []
        taskUsers = networkClient.send(request: request, type: [StatisticsUser].self) { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
            self?.taskUsers = nil
        }
    }
}
