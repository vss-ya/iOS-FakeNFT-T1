//
//  Nft.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

struct Nft: Codable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String
    let price: Float
    let author: String
    let id: String
}
