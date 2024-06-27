//
//  ProfileService.swift
//  FakeNFT
//
//  Created by vs on 27.06.2024.
//

import Foundation

typealias ProfileCompletion = (Result<Profile, Error>) -> Void

protocol ProfileService {
    func loadProfile(completion: @escaping ProfileCompletion)
}

final class ProfileServiceImpl: ProfileService {

    private let networkClient: NetworkClient
    private let storage: ProfileStorage

    init(networkClient: NetworkClient, storage: ProfileStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadProfile(completion: @escaping ProfileCompletion) {
        if let profile = storage.getProfile() {
            completion(.success(profile))
            return
        }

        let request = ProfileRequest()
        networkClient.send(request: request, type: Profile.self) { [weak storage] result in
            switch result {
            case .success(let profile):
                storage?.saveProfile(profile)
                completion(.success(profile))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
