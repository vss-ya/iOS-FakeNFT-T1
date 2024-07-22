//
//  ProfileViewController.swift
//  FakeNFT
//
//  Created by vs on 18.06.2024.
//

import UIKit
import Kingfisher

final class ProfileViewController: UIViewController {

    private enum Margin {
        static let left: CGFloat = 16
        static let right: CGFloat = 16
        static let editTop: CGFloat = 2
        static let editRight: CGFloat = 9
        static let avatarTop: CGFloat = 20
        static let avatarDia: CGFloat = 70
        static let headerLeft: CGFloat = 16
        static let descriptionTop: CGFloat = 20
        static let linkTop: CGFloat = 8
        static let tableTop: CGFloat = 40
    }

    private enum Constants {
        static let tableCellHeight: CGFloat = 54
    }

    private enum TableItem: CaseIterable {
        case myNft
        case favoritesNft
        case aboutDeveloper
    }

    private let editButton: UIButton
    private let avatarImageView: UIImageView
    private let headerLabel: UILabel
    private let descriptionLabel: UILabel
    private let linkLabel: UILabel
    private let tableView: UITableView

    private let tableItems = TableItem.allCases
    private let viewFactory = ProfileViewFactory.self
    private let viewModel: ProfileViewModelProtocol

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ viewModel: ProfileViewModelProtocol) {
        self.editButton = viewFactory.createEditButton()
        self.avatarImageView = viewFactory.createAvatarImageView()
        self.headerLabel = viewFactory.createHeaderLabel()
        self.descriptionLabel = viewFactory.createDescriptionLabel()
        self.linkLabel = viewFactory.createLinkLabel()
        self.tableView = viewFactory.createTableView()

        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        load()
    }

}

// MARK: - Helpers
private extension ProfileViewController {

    func setup() {
        setupViews()
        setupConstraints()
        bind()
    }

    func setupViews() {
        navigationItem.rightBarButtonItem = .init(customView: editButton)
        view.backgroundColor = .ypWhite

        [
            editButton,
            avatarImageView,
            headerLabel,
            descriptionLabel,
            linkLabel,
            tableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        tableView.dataSource = self
        tableView.delegate = self

        editButton.addTarget(self, action: #selector(editAction), for: .touchUpInside)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.avatarTop),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            avatarImageView.widthAnchor.constraint(equalToConstant: Margin.avatarDia),
            avatarImageView.heightAnchor.constraint(equalToConstant: Margin.avatarDia),
            headerLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 0),
            headerLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.headerLeft),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            descriptionLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Margin.descriptionTop),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            linkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Margin.descriptionTop),
            linkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.left),
            linkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.right),
            tableView.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: Margin.tableTop),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    func bind() {
        viewModel.onDidLoad = { [weak self](profile) in
            guard let self = self else {
                return
            }
            self.updateProfile(profile)
        }
        viewModel.onDidLoadWithError = { [weak self](error) in
            guard let self = self else {
                return
            }
            self.showError(error)
        }
    }

    func load() {
        showLoading()
        viewModel.load()
    }

    func updateProfile(_ profile: Profile) {
        hideLoading()
        headerLabel.text = profile.name
        descriptionLabel.text = profile.description
        linkLabel.text = profile.website
        updateAvatar(url: URL(string: profile.avatar ?? ""))
        tableView.reloadData()
    }

    func updateAvatar(url: URL?) {
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

// MARK: - Actions
extension ProfileViewController {

    @objc private func editAction() {
        let viewModel = ProfileEditViewModel(viewModel.servicesAssembly)
        let vc = ProfileEditViewController(viewModel) { [weak self]() in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true)
            self.load()
        }
        present(vc, animated: true, completion: nil)
    }

    private func openMyNft() {
        let viewModel = MyNftViewModel(viewModel.servicesAssembly)
        let vc = MyNftViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func openFavoritesNft() {
        let viewModel = FavoritesNftViewModel(viewModel.servicesAssembly)
        let vc = FavoritesNftViewController(viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }

    private func openAboutDeveloper() {
        let vc = AboutDeveloperViewController()
        present(vc, animated: true)
    }

}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.tableCellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        switch indexPath.row {
        case 0:
            openMyNft()
        case 1:
            openFavoritesNft()
        case 2:
            openAboutDeveloper()
        default:
            break
        }
    }

}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ProfileTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ProfileTableViewCell
        guard let cell = cell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        case 0:
            cell.update(title: L10n.Profile.myNft, count: viewModel.profile?.nfts.count ?? 0)
        case 1:
            cell.update(title: L10n.Profile.favoritesNft, count: viewModel.profile?.likes.count ?? 0)
        case 2:
            cell.update(title: L10n.Profile.aboutDeveloper, count: nil)
        default:
            break
        }
        return cell
    }

}
