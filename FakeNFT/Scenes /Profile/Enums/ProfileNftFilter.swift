//
//  ProfileNftFilter.swift
//  FakeNFT
//
//  Created by vs on 01.07.2024.
//

import Foundation

enum ProfileNftFilter: String, CaseIterable {
    case byPrice
    case byRaiting
    case byName
    
    var description: String {
        switch self {
        case .byPrice:
            return L10n.Profile.byPrice
        case .byRaiting:
            return L10n.Profile.byRating
        case .byName:
            return L10n.Profile.byName
        }
    }
}
