//
//  CatalogConstants.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 19.06.2024.
//

import Foundation

enum CatalogConstants {
    // MARK: - CatalogViewController
    static let catalogTableRowHeight = 186
    static let catalogCoverHeight = 140
    
    //MARK: - CollectionViewController
    static let catalogCollectionCoverHeight = 310
    static let catalogCollectionCellHeight = 192
    
    //MARK: - CatalogCollectionViewCell
    static let maxRating = 5
    
    
    
}

enum CatalogLocalization {
    //MARK: - CollectionViewController
    static let catalogCollectionAuthor = NSLocalizedString("Catalog.collectionAuthor", comment: "")
    
}

enum CatalogImages {
    //MARK: - CatalogCollectionViewCell
    static let delFromCart = "cart_delete"
    static let addToCart = "cart_add"
    static let favorites = "favourites_default"
    static let favouritesPressed = "favourites_pressed"
    static let starActive = "star_active"
    static let starNoActive = "star_no_active"
}
