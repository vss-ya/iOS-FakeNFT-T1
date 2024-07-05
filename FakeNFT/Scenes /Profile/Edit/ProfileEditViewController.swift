//
//  ProfileEditViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit
import Kingfisher

final class ProfileEditViewController: UIViewController {
    
    private enum Margin {
        static let top: CGFloat = 16
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let avatarTop: CGFloat = 22
        static let avatarDia: CGFloat = 70
        static let labelTop: CGFloat = 24
        static let textFieldTop: CGFloat = 8
    }
    
    private enum Constants {
        static let textFieldHeight: CGFloat = 44
        static let textViewHeight: CGFloat = 132
    }
    
    private let closeButton: UIButton
    private let scrollView: UIScrollView
    private let avatarImageView: UIImageView
    private let avatarButton: UIButton
    private let nameLabel: UILabel
    private let nameTextField: UITextField
    private let descriptionLabel: UILabel
    private let descriptionTextView: UITextView
    private let linkLabel: UILabel
    private let linkTextField: UITextField
    
    private let viewFactory = ProfileEditViewFactory.self
    private let viewModel: ProfileEditViewModelProtocol
    
    private var onCloseCallback: (()->(Void))?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: ProfileEditViewModelProtocol, onClose: (() -> Void)? = nil) {
        self.closeButton = viewFactory.createCloseButton()
        self.scrollView = UIScrollView()
        self.avatarImageView = viewFactory.createAvatarImageView()
        self.avatarButton = viewFactory.createAvatarButton()
        self.nameLabel = viewFactory.createLabel(L10n.Profile.name)
        self.nameTextField = viewFactory.createTextField()
        self.descriptionLabel = viewFactory.createLabel(L10n.Profile.description)
        self.descriptionTextView = viewFactory.createTextView()
        self.linkLabel = viewFactory.createLabel(L10n.Profile.link)
        self.linkTextField = viewFactory.createTextField()
        
        self.viewModel = viewModel
        self.onCloseCallback = onClose
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        load()
    }
    
}

// MARK: - Helpers
private extension ProfileEditViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
        
        nameTextField.delegate = self
        linkTextField.delegate = self
        
        let nameClearButton = nameTextField.rightView?.subviews.first as? UIButton
        let linkClearButton = linkTextField.rightView?.subviews.first as? UIButton
        
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        avatarButton.addTarget(self, action: #selector(avatarAction), for: .touchUpInside)
        nameClearButton?.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        linkClearButton?.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(tapAction), for: .primaryActionTriggered)
        linkTextField.addTarget(self, action: #selector(tapAction), for: .primaryActionTriggered)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        
        bind()
    }
    
    func setupViews() {
        view.backgroundColor = .ypWhite
        
        [
            scrollView,
            closeButton,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        [
            avatarImageView,
            avatarButton,
            nameLabel,
            nameTextField,
            descriptionLabel,
            descriptionTextView,
            linkLabel,
            linkTextField
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.top),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 80),
            avatarImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarImageView.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarButton.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor, constant: 0),
            avatarButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0),
            nameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Margin.left),
            nameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -Margin.right),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.labelTop),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Margin.textFieldTop),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 0),
            nameTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Margin.labelTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 0),
            descriptionTextView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margin.textFieldTop),
            descriptionTextView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: 0),
            descriptionTextView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: 0),
            descriptionTextView.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            linkLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: Margin.labelTop),
            linkLabel.leadingAnchor.constraint(equalTo: descriptionTextView.leadingAnchor, constant: 0),
            linkLabel.trailingAnchor.constraint(equalTo: descriptionTextView.trailingAnchor, constant: 0),
            linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: Margin.textFieldTop),
            linkTextField.leadingAnchor.constraint(equalTo: linkLabel.leadingAnchor, constant: 0),
            linkTextField.trailingAnchor.constraint(equalTo: linkLabel.trailingAnchor, constant: 0),
            linkTextField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            linkTextField.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
        ])
    }
    
    func bind() {
        viewModel.onDidLoad = { [weak self](profile) in
            guard let self = self else { return }
            updateProfile(profile)
        }
        viewModel.onDidLoadWithError = { [weak self](error) in
            guard let self = self else { return }
            showError(error)
            
        }
        viewModel.onDidUpdate = { [weak self](profile) in
            guard let self = self else { return }
            hideLoading()
            onCloseCallback?()
        }
        viewModel.onDidUpdateWithError = { [weak self](error) in
            guard let self = self else { return }
            showError(error)
            onCloseCallback?()
        }
    }
    
    func load() {
        showLoading()
        viewModel.load()
    }
    
    func updateProfile(_ profile: Profile) {
        hideLoading()
        nameTextField.text = profile.name
        descriptionTextView.text = profile.description
        linkTextField.text = profile.website
        updateAvatar(url: URL(string: profile.avatar ?? ""))
    }

    func updateAvatar(url: URL?) {
        viewModel.updateAvatar(url)
        
        let options: KingfisherOptionsInfo = [.scaleFactor(UIScreen.main.scale),
                                              .cacheOriginalImage]
        avatarImageView.kf.cancelDownloadTask()
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: url, placeholder: UIImage.profileAvatarMock, options: options)
    }
    
    func showError(_ error: Error) {
        UIBlockingProgressHUD.showError(error)
    }

    func showLoading() {
        UIBlockingProgressHUD.show()
    }

    func hideLoading() {
        UIBlockingProgressHUD.dismiss()
    }
    
}

extension ProfileEditViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        let btn = textField.rightView?.subviews.first
        btn?.isHidden = text.isEmpty
    }
    
}

// MARK: - Actions
private extension ProfileEditViewController {
    
    @objc func tapAction() {
        view.endEditing(true)
    }
    
    @objc func closeAction() {
        guard let oldProfile = viewModel.profile else {
            return
        }
        let avatar = viewModel.avatarUrl?.absoluteString
        let profile = Profile(
            id: oldProfile.id,
            name: nameTextField.text ?? "",
            avatar: avatar,
            description: descriptionTextView.text,
            website: linkTextField.text,
            nfts: oldProfile.nfts,
            likes: oldProfile.likes
        )
        showLoading()
        viewModel.update(profile)
    }
    
    @objc func clearAction() {
        let textField = [nameTextField, linkTextField].first(where: { $0.isFirstResponder })
        textField?.text = ""
    }
    
    @objc func avatarAction() {
        let alert = UIAlertController(
            title: L10n.Profile.loadImage,
            message: L10n.Profile.pasteLinkToImage,
            preferredStyle: .alert
        )

        alert.addTextField { [weak self] in
            $0.text = self?.viewModel.avatarUrl?.absoluteString
        }
        
        let action = UIAlertAction(
            title: "ОK",
            style: .default)
        { [weak self] _ in
            guard let self, let urlString = alert.textFields?[0].text else {
                return
            }
            updateAvatar(url: URL(string: urlString))
            alert.dismiss(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
