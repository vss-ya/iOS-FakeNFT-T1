//
//  StatisticsUserViewController.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit
import Kingfisher

final class StatisticsUserViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .ypBlack
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
        label.numberOfLines = 0
        return label
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private lazy var userWebsiteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitle(
            NSLocalizedString("Statistics.statisticsProfile.userWebsiteButton", comment: ""),
            for: .normal
        )
        button.setTitleColor(.ypBlack, for: .normal)
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
    private lazy var nftsCollectionTextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setTitleColor(.ypBlack, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didTapNftsCollectionButton), for: .touchUpInside)
        return button
    }()
    private lazy var nftsCollectionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.tintColor = .ypBlack
        button.addTarget(self, action: #selector(didTapNftsCollectionButton), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: StatisticsUserViewModelProtocol
    
    private var website: String = ""
    private var nftsIds: [String] = []
    
    var dismissClosure: (() -> Void)?
    
    // MARK: - Lifecycle
    
    init(viewModel: StatisticsUserViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        userWebsiteButton.layer.borderColor = UIColor.ypBlack.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        UIBlockingProgressHUD.show()
        viewModel.getUser()
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
            subview.translatesAutoresizingMaskIntoConstraints = false
            avatarStackView.addSubview(subview)
        }
        [nftsCollectionTextButton, nftsCollectionButton].forEach { subview in
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
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
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
            userWebsiteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
            nftsCollectionTextButton.leadingAnchor.constraint(equalTo: nftsStackView.leadingAnchor),
            nftsCollectionTextButton.trailingAnchor.constraint(equalTo: nftsCollectionButton.leadingAnchor, constant: -16),
            nftsCollectionTextButton.centerYAnchor.constraint(equalTo: nftsCollectionButton.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            nftsCollectionButton.trailingAnchor.constraint(equalTo: nftsStackView.trailingAnchor),
            nftsCollectionButton.centerYAnchor.constraint(equalTo: nftsStackView.centerYAnchor),
            nftsCollectionButton.widthAnchor.constraint(equalToConstant: 16),
            nftsCollectionButton.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    private func bind() {
        viewModel.updateData = { [weak self] user in
            UIBlockingProgressHUD.dismiss()
            guard let self else { return }
            self.website = user.website ?? ""
            if let url = URL(string: user.avatar ?? "") {
                let processor = RoundCornerImageProcessor(cornerRadius: 14)
                avatarImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(systemName: "person.crop.circle.fill"),
                    options: [.processor(processor)]
                )
            } else {
                avatarImageView.image = UIImage(systemName: "person.crop.circle.fill")
            }
            nameLabel.text = user.name
            descriptionLabel.text = user.description
            let nftsCollectionTitle = NSLocalizedString("Statistics.statisticsProfile.nftsCollectionButton", comment: "")
            nftsCollectionTextButton.setTitle(
                nftsCollectionTitle + " (\(user.nfts.count))",
                for: .normal
            )
            nftsIds = user.nfts
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        dismiss(animated: false)
        dismissClosure?()
    }
    
    @objc private func didTapUserWebsiteButton() {
        let statisticsWebViewViewController = StatisticsWebViewViewController(viewModel: StatisticsWebViewViewModel(website: website))
        self.present(statisticsWebViewViewController, animated: true)
    }
    
    @objc private func didTapNftsCollectionButton() {
        let statisticsUserCollectionViewController = StatisticsUserCollectionViewController(viewModel: StatisticsUserCollectionViewModel(ids: nftsIds))

        let statisticsUserCollectionNavigationController = UINavigationController(rootViewController: statisticsUserCollectionViewController)
        statisticsUserCollectionNavigationController.modalPresentationStyle = .overCurrentContext
        
        self.present(statisticsUserCollectionNavigationController, animated: true)
    }
}
