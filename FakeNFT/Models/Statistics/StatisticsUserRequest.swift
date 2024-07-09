//
//  StatisticsUserRequest.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 24.06.2024.
//

import Foundation

struct StatisticsUserRequest: NetworkRequest {
    let id: String
    
    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/users/\(id)")
    }
}

