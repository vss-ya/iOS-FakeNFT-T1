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
    var updateProgressValue: Binding<Double>?
    
    init(website: String) {
        self.website = website
    }
    
    func initialize() {
        guard let url = URL(string: website) else { return }
        updateData?(URLRequest(url: url))
    }
}
