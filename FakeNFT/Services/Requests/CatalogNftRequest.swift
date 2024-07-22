//
//  CatalogNftRequest.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 27.06.2024.
//

import Foundation

struct CatalogNftRequest: NetworkRequest {

    var id: String

    var endpoint: URL? {
        guard let urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)") else { return nil }
        return urlComponents.url
    }
}
