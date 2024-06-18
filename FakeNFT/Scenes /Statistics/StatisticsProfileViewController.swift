//
//  StatisticsProfileViewController.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit

final class StatisticsProfileViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    private lazy var avatarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.layer.masksToBounds = true
        imageView.tintColor = .ypGrayUniversal
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    private lazy var userWebsiteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle(
            NSLocalizedString("Statistics.statisticsProfile.userWebsiteButton", comment: ""),
            for: .normal
        )
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.ypBlack.cgColor
        button.addTarget(self, action: #selector(didTapUserWebsiteButton), for: .touchUpInside)
        return button
    }()
    private lazy var nftsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var nftsCollectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    private lazy var nftsCollectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.addTarget(self, action: #selector(didTapNftsCollectionButton), for: .touchUpInside)
        return button
    }()
    
    var profile: StatisticsProfile? {
        didSet {
            guard let profile else { return }
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        view.backgroundColor = .ypWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [backButton, avatarStackView, descriptionLabel, userWebsiteButton, nftsStackView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        [avatarImageView, nameLabel].forEach { subview in
            avatarStackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
        [nftsCollectionLabel, nftsCollectionButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            nftsStackView.addSubview(subview)
        }
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            avatarStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            avatarStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            avatarStackView.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: avatarStackView.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: avatarStackView.topAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: avatarStackView.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: avatarStackView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: avatarStackView.bottomAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            userWebsiteButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 28),
            userWebsiteButton.widthAnchor.constraint(equalToConstant: 343),
            userWebsiteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            nftsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nftsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nftsStackView.topAnchor.constraint(equalTo: userWebsiteButton.bottomAnchor, constant: 56),
            nftsStackView.heightAnchor.constraint(equalToConstant: 54)
        ])
        NSLayoutConstraint.activate([
            nftsCollectionLabel.leadingAnchor.constraint(equalTo: nftsStackView.leadingAnchor),
            nftsCollectionLabel.trailingAnchor.constraint(equalTo: nftsCollectionButton.leadingAnchor, constant: -16),
            nftsCollectionLabel.centerYAnchor.constraint(equalTo: nftsCollectionButton.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nftsCollectionButton.trailingAnchor.constraint(equalTo: nftsStackView.trailingAnchor),
            nftsCollectionLabel.centerYAnchor.constraint(equalTo: nftsCollectionButton.centerYAnchor),
            nftsCollectionLabel.widthAnchor.constraint(equalToConstant: 16),
            nftsCollectionLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        
    }
    
    @objc private func didTapUserWebsiteButton() {
        
    }
    
    @objc private func didTapNftsCollectionButton() {
        
    }
}