//
//  StatisticsCartRequest.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 25.06.2024.
//

import Foundation

struct StatisticsCartRequest: NetworkRequest {
    
    let httpBody: Data?
    
    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    
    var httpMethod: HttpMethod = .put
}

