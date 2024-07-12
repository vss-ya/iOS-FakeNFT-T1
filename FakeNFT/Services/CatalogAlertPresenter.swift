//
//  CatalogAlertPresenter.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 04.07.2024.
//

import UIKit

final class CatalogAlertPresenter {
    static func showAlert(delegate: UIViewController?, repeatCompletion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: CatalogLocalization.catalogAlertTitle,
            message: CatalogLocalization.catalogAlertMessage,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(
            title: CatalogLocalization.catalogAlertReload,
            style: .default
        ) { _ in
            repeatCompletion() }
        )

        alert.addAction(UIAlertAction(
            title: CatalogLocalization.catalogSortCancel,
            style: .cancel
        )
        )

        delegate?.present(alert, animated: true)
    }

}
