//
//  StatisticsUser.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

struct StatisticsUser: Decodable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let rating: String
    let id: String
    
    init(name: String, avatar: String, description: String, website: String, nfts: [String], rating: String, id: String) {
        self.name = name
        self.avatar = avatar
        self.description = description
        self.website = website
        self.nfts = nfts
        self.rating = rating
        self.id = id
    }
}
