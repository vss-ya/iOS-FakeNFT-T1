//
//  StatisticsUserViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 21.06.2024.
//

import Foundation

protocol StatisticsUserViewModelProtocol {
    var updateData: Binding<StatisticsUser>? { get set }
    
    init(id: String)
    func getUser()
}
