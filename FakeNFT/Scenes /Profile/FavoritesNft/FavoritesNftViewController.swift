//
//  FavoritesNftViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit

final class FavoritesNftViewController: UIViewController {
    
    private let viewModel: FavoritesNftViewModelProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: FavoritesNftViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.Profile.favoritesNft
    }
    
}
