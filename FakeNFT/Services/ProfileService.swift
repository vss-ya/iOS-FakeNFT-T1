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
    func updateProfile(_ profile: Profile, completion: @escaping ProfileCompletion)
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
    
    func updateProfile(_ profile: Profile, completion: @escaping ProfileCompletion) {
        guard let urlRequest = makePutRequest(with: profile) else {
            let error = NSError(domain: "URL request error", code: 0)
            completion(.failure(NetworkClientError.urlRequestError(error)))
            return
        }
        networkClient.send(urlRequest: urlRequest, type: Profile.self) { [weak storage] result in
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

private extension ProfileServiceImpl {
    
    func makePutRequest(with profile: Profile) -> URLRequest? {
        guard let url = ProfileRequest().endpoint else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.put.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")

        var profileData: String = ""
        profileData += "&likes=\(profile.likes.joined(separator: ","))"
        profileData += "&name=\(profile.name)"
        profileData += "&avatar=\((profile.avatar?.absoluteString ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"
        profileData += "&description=\(profile.description ?? "")"
        profileData += "&website=\((profile.website?.absoluteString ?? "").addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")"

        request.httpBody = profileData.data(using: .utf8)

        return request

    }
    
}
