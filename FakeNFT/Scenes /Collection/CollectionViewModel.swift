//
//  CollectionViewModel.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import Foundation

protocol CollectionViewModelProtocol: AnyObject {
    func getNftNumber() -> Int
    func getNfts() -> [Nft]
    
}

final class CollectionViewModel: CollectionViewModelProtocol {
    private let nft = MokNft.shared
    
    func getNftNumber() -> Int {
        nft.nft.count
    }
    
    func getNfts() -> [Nft] {
        nft.nft
    }
    
    
}
