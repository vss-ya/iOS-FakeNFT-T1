//
//  StatisticsWebViewViewModelProtocol.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import Foundation

protocol StatisticsWebViewViewModelProtocol {
    var updateData: Binding<URLRequest>? { get set }
    var updateProgressValue: Binding<Float>? { get set }
    var hideProgress: Binding<Bool>? { get set }
    
    init(website: String)
    func getData()
    func didUpdateProgressValue(_ newValue: Double)
}
