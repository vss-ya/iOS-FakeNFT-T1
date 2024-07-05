//
//  StatisticsUserCollectionViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 22.06.2024.
//

import Foundation

final class StatisticsUserCollectionViewModel: StatisticsUserCollectionViewModelProtocol {
    private let dataStore = StatisticsDataStore.shared
    
    var updateData: Binding<Bool>?
    var updateNft: Binding<Int>?
    
    private var ids: [String]
    private var nfts: [StatisticsNft?]
    private var order: StatisticsOrder?
    
    var numberOfSections: Int {
        return 1
    }
    
    init(ids: [String]) {
        self.ids = ids
        self.nfts = [StatisticsNft?](repeating: nil, count: ids.count)
        dataStore.getOrder { [weak self] order in
            self?.order = order
        }
    }
    
    func getData() {
        updateData?(true)
        for i in 0 ..< ids.count {
            dataStore.getNftById(id: ids[i]) { [weak self] nft in
                if let nft, let self {
                    self.nfts[i] = nft
                    self.updateNft?(i)
                }
            }
        }
    }
    
    func numberOfItemsInSection(_ section: Int) -> Int {
        return nfts.count
    }
    
    func model(at indexPath: IndexPath) -> any Decodable {
        return nfts[indexPath.row]
    }
    
    func inCart(id: String) -> Bool {
        var result = false
        order?.nfts.forEach { nft in
            if nft == id {
                result = true
            }
        }
        return result
    }
    
    func addToCart(id: String, completion: @escaping () -> Void) {
        guard let order else { return }
        var newNfts = order.nfts
        newNfts.append(id)
        dataStore.sendCart(nfts: newNfts) { result in
            if result {
                self.order?.nfts = newNfts
                completion()
            }
        }
    }
    
    func removeFromCart(id: String, completion: @escaping () -> Void) {
        guard let order else { return }
        var newNfts = order.nfts
        newNfts.removeAll(where: {$0 == id})
        dataStore.sendCart(nfts: newNfts) { result in
            if result {
                self.order?.nfts = newNfts
                completion()
            }
        }
    }
}
