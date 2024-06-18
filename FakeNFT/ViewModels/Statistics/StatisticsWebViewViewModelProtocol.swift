//
//  StatisticsWebViewViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

protocol StatisticsWebViewViewModelProtocol {
    init(website: String)
    func updateProgressValue(_ newValue: Double)
}
