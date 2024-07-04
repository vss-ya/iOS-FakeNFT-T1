//
//  CatalogRequest.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 25.06.2024.
//

import Foundation


struct CatalogRequest: NetworkRequest {
    
    var endpoint: URL? {
        guard let urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/collections") else { return nil }
        return urlComponents.url
    }
}
