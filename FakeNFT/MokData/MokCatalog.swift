//
//  MokCatalog.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

final class MokCatalog {
    static let shared = MokCatalog()
    private init() {}
    
    var collections: [Catalog] = [
        Catalog(
            createdAt: "2023-11-21T15:21:36.683Z[GMT]",
            name: "singulis epicuri",
            cover: "Brown",
            nfts: ["c14cf3bc-7470-4eec-8a42-5eaa65f4053c",
                   "d6a02bd1-1255-46cd-815b-656174c1d9c0",
                   "f380f245-0264-4b42-8e7e-c4486e237504"],
            description: "curabitur feugait a definitiones singulis movet eros aeque mucius evertitur assueverit et eam",
            author: "Lourdes Harper",
            id: "d4fea6b6-91f1-45ce-9745-55431e69ef5c"),
        Catalog(
            createdAt: "2023-11-21T15:21:36.691Z[GMT]",
            name: "unum reque",
            cover: "White",
            nfts: ["82570704-14ac-4679-9436-050f4a32a8a0",
                   "e33e18d5-4fc2-466d-b651-028f78d771b8"],
            description: "dictas singulis placerat interdum maximus referrentur partiendo explicari verear molestiae",
            author: "Darren Morris",
            id: "81268b05-db02-4bc9-b0b0-f7136de49706"),
        Catalog(
            createdAt: "2023-11-21T15:21:36.692Z[GMT]",
            name: "quem varius",
            cover: "Pink",
            nfts: ["9810d484-c3fc-49e8-bc73-f5e602c36b40",
                   "e8c1f0b6-5caf-4f65-8e5b-12f4bcb29efb"],
            description: "delectus atqui metus sit posuere vocibus urbanitas partiendo definitionem tempus meliore conclusionemque",
            author: "Barry Sheppard",
            id: "49a96d73-d58f-4c01-8ce3-7d6949c980ca"),
    ]
    
}
