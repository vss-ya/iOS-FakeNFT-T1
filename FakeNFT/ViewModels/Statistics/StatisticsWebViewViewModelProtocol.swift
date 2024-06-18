//
//  StatisticsWebViewViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

protocol StatisticsWebViewViewModelProtocol {
    var updateData: Binding<URLRequest>? { get set }
    var updateProgressValue: Binding<Double>? { get set }
    
    init(website: String)
    func initialize()
}
