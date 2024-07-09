//
//  StatisticsOrderRequest.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 25.06.2024.
//

import Foundation

struct StatisticsOrderRequest: NetworkRequest {
    var endpoint: URL? {
        return URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
}
