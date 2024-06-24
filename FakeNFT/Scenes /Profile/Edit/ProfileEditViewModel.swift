//
//  ProfileEditViewModel.swift
//  FakeNFT
//
//  Created by vs on 25.06.2024.
//

import Foundation

protocol ProfileEditViewModelProtocol {
    
    var servicesAssembly: ServicesAssembly { get }
    
    init(_ servicesAssembly: ServicesAssembly)
    
}

final class ProfileEditViewModel: ProfileEditViewModelProtocol {
    
    let servicesAssembly: ServicesAssembly
    
    init(_ servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
}
