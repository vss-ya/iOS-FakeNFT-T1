//
//  StatisticsCollectionsViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

enum StatisticsSortFields {
    case byName, byRating
}

protocol StatisticsCollectionsViewModelProtocol {
    var updateData: Binding<Bool>? { get set }
    var numberOfSections: Int { get }
    
    func getData(sortField: StatisticsSortFields)
    func numberOfItemsInSection(_ section: Int) -> Int
    func model(at indexPath: IndexPath) -> Decodable
}
