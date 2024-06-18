//
//  StatisticsCollectionsViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

protocol StatisticsCollectionsViewModelProtocol{
    var updateData: Binding<Bool>? { get set }
    var numberOfSections: Int { get }
    
    func initialize()
    func numberOfRowsInSection(_ section: Int) -> Int
    func model(at indexPath: IndexPath) -> Decodable
}
