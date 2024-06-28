//
//  Profile.swift
//  FakeNFT
//
//  Created by vs on 27.06.2024.
//

import Foundation

struct Profile: Decodable {
    
    let id: String
    let name: String
    let avatar: String?
    let description: String?
    let website: String?
    let nfts: [String]
    let likes: [String]
    
}
