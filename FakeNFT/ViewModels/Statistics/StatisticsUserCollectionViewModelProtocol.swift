//
//  StatisticsUserCollectionViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 24.06.2024.
//

import Foundation

protocol StatisticsUserCollectionViewModelProtocol {
    var updateData: Binding<Bool>? { get set }
    var updateNft: Binding<Int>? { get set }
    var numberOfSections: Int { get }
    
    init(ids: [String])
    func getData()
    func numberOfItemsInSection(_ section: Int) -> Int
    func model(at indexPath: IndexPath) -> Decodable
    func inCart(id: String) -> Bool
}
