//
//  ProfileEditViewModel.swift
//  FakeNFT
//
//  Created by vs on 25.06.2024.
//

import Foundation

protocol ProfileEditViewModelProtocol: AnyObject {
    typealias Binding<T> = (T) -> Void
    
    var servicesAssembly: ServicesAssembly { get }
    
    var profile: Profile? { get  }
    var avatarUrl: URL? { get  }
    var onDidLoad: Binding<Profile>? { get set }
    var onDidLoadWithError: Binding<Error>? { get set }
    var onDidUpdate: Binding<Profile>? { get set }
    var onDidUpdateWithError: Binding<Error>? { get set }
    
    init(_ servicesAssembly: ServicesAssembly)
    
    func load()
    func update(_ profile: Profile)
    func updateAvatar(_ url: URL?)
    
}

final class ProfileEditViewModel: ProfileEditViewModelProtocol {
    
    let servicesAssembly: ServicesAssembly
    
    private var service: ProfileService { servicesAssembly.profileService }
    private(set) var profile: Profile?
    private(set) var avatarUrl: URL?
    
    var onDidLoad: Binding<Profile>?
    var onDidLoadWithError: Binding<Error>?
    var onDidUpdate: Binding<Profile>?
    var onDidUpdateWithError: Binding<Error>?
    
    init(_ servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
    }
    
    func load() {
        service.loadProfile { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.avatarUrl = URL(string: profile.avatar ?? "")
                    self?.onDidLoad?(profile)
                case .failure(let error):
                    self?.onDidLoadWithError?(error)
                }
            }
        }
    }
    
    func update(_ profile: Profile) {
        service.updateProfile(profile) { [weak self](result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.onDidUpdate?(profile)
                case .failure(let error):
                    self?.onDidUpdateWithError?(error)
                }
            }
        }
    }
    
    func updateAvatar(_ url: URL?) {
        avatarUrl = url
    }
    
}
