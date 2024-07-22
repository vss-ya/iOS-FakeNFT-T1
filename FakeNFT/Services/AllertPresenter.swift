//
//  AllertPresenter.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit

final class AlertPresenter {
    static func statisticsSort(delegate: UIViewController?, deleteCompletion: @escaping (_ sortField: StatisticsSortFields) -> Void) {
        let alert = UIAlertController(
            title: NSLocalizedString("Statistics.statisticsSort.title", comment: ""),
            message: "",
            preferredStyle: .actionSheet
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Statistics.statisticsSort.byName", comment: ""),
                style: .default
            ) { _ in
                deleteCompletion(.byName)
            }
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Statistics.statisticsSort.byRating", comment: ""),
                style: .default
            ) { _ in
                deleteCompletion(.byRating)
            }
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Statistics.statisticsSort.close", comment: ""),
                style: .cancel
            )
        )
        delegate?.present(alert, animated: true, completion: nil)
    }

    static func loadDataError(delegate: UIViewController?, repeatCompletion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: NSLocalizedString("Statistics.loadDataError.title", comment: ""),
            message: "",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Statistics.loadDataError.cancel", comment: ""),
                style: .default
            )
        )
        alert.addAction(
            UIAlertAction(
                title: NSLocalizedString("Statistics.loadDataError.repeat", comment: ""),
                style: .default
            ) { _ in
                repeatCompletion()
            }
        )
        delegate?.present(alert, animated: true, completion: nil)
    }
}
