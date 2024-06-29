//
//  StatisticsDataStore.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsDataStore {
    static let shared = StatisticsDataStore()
    
    private var taskUsers: NetworkTask?
    private var taskUser: NetworkTask?
    private var taskNft: NetworkTask?
    private var taskOrder: NetworkTask?
    private var taskCart: NetworkTask?
    
    private init() {}
    
    func getUsers(sortField: StatisticsSortFields, completion: @escaping ([StatisticsUser]) -> Void) {
        if taskUsers != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = StatisticsUsersRequest(sortField: sortField)
        taskUsers = networkClient.send(request: request, type: [StatisticsUser].self) { [weak self] result in
            switch result {
            case .success(let users):
                completion(users)
            case .failure(let error):
                print(error.localizedDescription)
                completion([])
            }
            self?.taskUsers = nil
        }
    }
    
    func getUser(id: String, completion: @escaping (StatisticsUser?) -> Void) {
        if taskUser != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = StatisticsUserRequest(id: id)
        taskUsers = networkClient.send(request: request, type: StatisticsUser.self) { [weak self] result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
            self?.taskUser = nil
        }
    }
    
    func getNftById(id: String, completion: @escaping (StatisticsNft?) -> Void) {
        if taskNft != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = StatisticsNftRequest(id: id)
        taskUsers = networkClient.send(request: request, type: StatisticsNft.self) { [weak self] result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
            self?.taskNft = nil
        }
    }
    
    func getOrder(completion: @escaping (StatisticsOrder?) -> Void) {
        if taskOrder != nil { return }
        let networkClient = DefaultNetworkClient()
        let request = StatisticsOrderRequest()
        taskUsers = networkClient.send(request: request, type: StatisticsOrder.self) { [weak self] result in
            switch result {
            case .success(let order):
                completion(order)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
            self?.taskOrder = nil
        }
    }
    
    func sendCart(nfts: [String], completion: @escaping (Bool) -> Void) {
        if taskCart != nil { return }
        let networkClient = DefaultNetworkClient()
        let bodyString = "nfts=\(nfts.joined(separator: ","))"
        guard let bodyData = bodyString.data(using: .utf8) else { return }
        let request = StatisticsCartRequest(httpBody: bodyData)
        taskUsers = networkClient.send(request: request, type: StatisticsOrder.self) { [weak self] result in
            switch result {
            case .success(_):
                completion(true)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false)
            }
            self?.taskCart = nil
            
        }
    }
}
