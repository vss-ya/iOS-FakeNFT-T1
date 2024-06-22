//
//  StatisticsUsersRequest.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

struct StatisticsUsersRequest: NetworkRequest {
    let sortField: StatisticsSortFields
    
    var endpoint: URL? {
        guard var urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/users") else { return nil }
        switch sortField {
        case .byName:
            urlComponents.queryItems = [
                URLQueryItem(name: "sortBy", value: "name"),
                URLQueryItem(name: "order", value: "asc")
            ]
        case .byRating:
            urlComponents.queryItems = [
                URLQueryItem(name: "sortBy", value: "rating"),
                URLQueryItem(name: "order", value: "asc")
            ]
        }
        return urlComponents.url
    }
}
