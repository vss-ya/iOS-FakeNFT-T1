//
//  ProfileViewModel.swift
//  FakeNFT
//
//  Created by vs on 25.06.2024.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    typealias Binding<T> = (T) -> Void
    
    var servicesAssembly: ServicesAssembly { get }
    
    var profile: Profile? { get  }
    var onDidLoad: Binding<Profile>? { get set }
    var onDidLoadWithError: Binding<Error>? { get set }
    
    init(_ servicesAssembly: ServicesAssembly)
    
    func load()
}

final class ProfileViewModel: ProfileViewModelProtocol {
    
    let servicesAssembly: ServicesAssembly
    
    private var service: ProfileService { servicesAssembly.profileService }
    private(set) var profile: Profile?
    
    var onDidLoad: Binding<Profile>?
    var onDidLoadWithError: Binding<Error>?
    
    init(_ servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func load() {
        service.loadProfile { [weak self](result) in
            switch result {
            case .success(let profile):
                self?.profile = profile
                self?.onDidLoad?(profile)
            case .failure(let error):
                self?.onDidLoadWithError?(error)
            }
        }
    }
    
}
