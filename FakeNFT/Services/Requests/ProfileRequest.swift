//
//  ProfileRequest.swift
//  FakeNFT
//
//  Created by vs on 27.06.2024.
//

import Foundation

struct ProfileRequest: NetworkRequest {
    
    var endpoint: URL? {
        guard var urlComponents = URLComponents(string: "\(RequestConstants.baseURL)/api/v1/profile/1") else { return nil }
        return urlComponents.url
    }
    
}
