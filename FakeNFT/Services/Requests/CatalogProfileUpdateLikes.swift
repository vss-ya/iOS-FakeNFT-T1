//
//  CatalogProfileUpdateLikes.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 04.07.2024.
//

import Foundation

struct CatalogProfileUpdateLikes: NetworkRequest {

    var id: String = "1"

    var httpMethod: HttpMethod = .put

    let httpBody: Data?

    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/\(id)")
    }

}
