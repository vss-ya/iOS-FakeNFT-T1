//
//  ProfileStorage.swift
//  FakeNFT
//
//  Created by vs on 27.06.2024.
//

import Foundation

protocol ProfileStorage: AnyObject {
    func saveProfile(_ profile: Profile)
    func getProfile() -> Profile?
}

final class ProfileStorageImpl: ProfileStorage {
    private var profile: Profile?
    private let syncQueue = DispatchQueue(label: "sync-profile-queue")

    func saveProfile(_ profile: Profile) {
        syncQueue.async { [weak self] in
            self?.profile = profile
        }
    }

    func getProfile() -> Profile? {
        syncQueue.sync {
            profile
        }
    }
}
