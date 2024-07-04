//
//  CatalogCartUpdate.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 04.07.2024.
//

import Foundation

struct CatalogCartUpdate: NetworkRequest {
    
    var id: String = "1"
    
    var httpMethod: HttpMethod = .put
    
    let httpBody: Data?
    
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/\(id)")
    }
    
    
}
