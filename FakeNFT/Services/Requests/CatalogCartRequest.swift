//
//  CatalogCartRequest.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 04.07.2024.
//

import Foundation

struct CatalogCartRequest: NetworkRequest {

    var id: String = "1"

    var endpoint: URL? {
        guard let urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/orders/\(id)") else { return nil }
        return urlComponents.url
    }
}
