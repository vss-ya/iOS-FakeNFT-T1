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
    static let catalogAuthorLink = "https://ru.wikipedia.org/wiki/Пушкин,_Александр_Сергеевич"
    
    //MARK: - CatalogCollectionViewCell
    static let maxRating = 5
    
    
    
}

enum CatalogLocalization {
    //MARK: - CatalogViewController
    static let catalogSortMessage = NSLocalizedString("Catalog.sortMessage", comment: "")
    static let catalogSortByName = NSLocalizedString("Catalog.sortByName", comment: "")
    static let catalogSortByNftCount = NSLocalizedString("Catalog.sortByNftCount", comment: "")
    static let catalogSortCancel = NSLocalizedString("Catalog.sortCancel", comment: "")
    
    //MARK: - CollectionViewController
    static let catalogCollectionAuthor = NSLocalizedString("Catalog.collectionAuthor", comment: "")
    
    //MARK: - CatalogAlertPresenter
    static let catalogAlertTitle = NSLocalizedString("Error.title", comment: "")
    static let catalogAlertReload = NSLocalizedString("Error.repeat", comment: "")
    static let catalogAlertMessage = NSLocalizedString("Error.network", comment: "") 
    
}

enum CatalogImages {
    //MARK: - CatalogViewController
    static let catalogSortButton = "sort"
    
    //MARK: - CollectionViewController
    static let catalogBackButton = "back"
    
    
    //MARK: - CatalogCollectionViewCell
    static let delFromCart = "cart_delete"
    static let addToCart = "cart_add"
    static let favorites = "favourites_default"
    static let favouritesPressed = "favourites_pressed"
    static let starActive = "star_active"
    static let starNoActive = "star_no_active"
}
