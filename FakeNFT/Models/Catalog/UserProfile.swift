//
//  UserProfile.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 03.07.2024.
//

import Foundation

struct UserProfile: Codable {
    let name: String
    let avatar: String
    let description: String
    let website: String
    let nfts: [String]
    let likes: [String]
    let id: String
}
