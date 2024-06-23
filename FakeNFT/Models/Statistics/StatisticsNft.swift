//
//  StatisticsNft.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

struct StatisticsNft: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
    
    init(createdAt: String, name: String, images: [String], rating: Int, description: String, price: Float, author: String, id: String) {
        self.createdAt = createdAt
        self.name = name
        self.images = images
        self.rating = rating
        self.description = description
        self.price = price
        self.author = author
        self.id = id
    }
}
