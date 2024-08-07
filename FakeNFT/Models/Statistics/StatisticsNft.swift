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
}
