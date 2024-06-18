//
//  ProfileViewFactory.swift
//  FakeNFT
//
//  Created by vs on 18.06.2024.
//

import UIKit

final class ProfileViewFactory {
    
    static func initEditButton() -> UIButton {
        let btn = UIButton()
        btn.setImage(.profileEdit, for: .normal)
        return btn
    }
    
    static func initAvatarImageView() -> UIImageView {
        let view = UIImageView()
        view.image = .profileAvatarMock
        return view
    }
    
    static func initHeaderLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Joaquin Phoenix"
        return label
    }
    
    static func initDescriptionLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.text = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
        label.numberOfLines = 0
        return label
    }
    
    static func initLinkLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .ypBlueUniversal
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Joaquin Phoenix.com"
        return label
    }
    
    static func initTableView() -> UITableView {
        let view = UITableView()
        view.separatorStyle = .none
        view.alwaysBounceVertical = false
        view.backgroundColor = .ypWhite
        view.register(ProfileTableViewCell.self,
                      forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
        return view
    }
    
}
