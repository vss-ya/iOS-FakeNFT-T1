//
//  CatalogUserProfileRequest.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 03.07.2024.
//

import Foundation

struct CatalogUserProfileRequest: NetworkRequest {
    
    var id: String = "1"

    var endpoint: URL? {
        guard let urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/profile/\(id)") else { return nil }
        return urlComponents.url
    }
}
