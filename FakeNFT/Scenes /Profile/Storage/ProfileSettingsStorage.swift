//
//  ProfileSettingsStorage.swift
//  FakeNFT
//
//  Created by vs on 01.07.2024.
//

import Foundation

class ProfileSettingsStorage {
    
    enum Key: String {
        case nftFilter = "profile.nft.filter"
    }
    
    static let shared = ProfileSettingsStorage()
    
    private var userDefaults: UserDefaults = UserDefaults.standard
    
    var nftFilter: ProfileNftFilter {
        set { userDefaults.set(newValue.rawValue, forKey: Key.nftFilter.rawValue) }
        get {
            let value = userDefaults.string(forKey: Key.nftFilter.rawValue) ?? ""
            return ProfileNftFilter(rawValue: value) ?? .byRaiting
        }
    }
    
}
