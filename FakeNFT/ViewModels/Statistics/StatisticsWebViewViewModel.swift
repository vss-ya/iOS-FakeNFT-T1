//
//  StatisticsWebViewViewModel.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

final class StatisticsWebViewViewModel: StatisticsWebViewViewModelProtocol {
    private let website: String

    var updateData: Binding<URLRequest>?
    var updateProgressValue: Binding<Float>?
    var hideProgress: Binding<Bool>?

    init(website: String) {
        self.website = website
    }

    func getData() {
        guard let url = URL(string: website) else { return }
        updateData?(URLRequest(url: url))
    }

    func didUpdateProgressValue(_ newValue: Double) {
        let newProgressValue = Float(newValue)
        updateProgressValue?(newProgressValue)
        hideProgress?(shouldHideProgress(for: newProgressValue))
    }

    private func shouldHideProgress(for value: Float) -> Bool {
        return abs(value - 1.0) <= 0.0001
    }
}
