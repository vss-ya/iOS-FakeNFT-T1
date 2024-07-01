//
//  MyNftViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit
import ProgressHUD

final class MyNftViewController: UIViewController {
    
    override var hidesBottomBarWhenPushed: Bool {
        set {} get { true }
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.profileBack, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.sort, for: .normal)
        button.addTarget(self, action: #selector(sortAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .ypWhite
        tableView.register(MyNftTableViewCell.self,
                           forCellReuseIdentifier: MyNftTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var noMyNftLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = L10n.Profile.noMyNft
        return label
    }()
    
    private let viewModel: MyNftViewModelProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: MyNftViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        load()
    }
    
}

// MARK: - Helpers
private extension MyNftViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
        bind()
    }
    
    func setupViews() {
        title = L10n.Profile.myNft
        navigationItem.leftBarButtonItem = .init(customView: backButton)
        navigationItem.rightBarButtonItem = .init(customView: sortButton)
        view.backgroundColor = .ypWhite
        noMyNftLabel.isHidden = true
        [tableView, noMyNftLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            noMyNftLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            noMyNftLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
        ])
    }
    
    func bind() {
        viewModel.onDidLoad = { [weak self](nfts) in
            guard let self else { return }
            didLoad()
        }
        viewModel.onDidLoadWithError = { [weak self](error) in
            guard let self else { return }
            showError(error)
        }
    }
    
    func load() {
        showLoading()
        viewModel.load()
    }
    
    func didLoad() {
        tableView.reloadData()
        noMyNftLabel.isHidden = !viewModel.nfts.isEmpty
        hideLoading()
    }
    
    func showError(_ error: Error) {
        ProgressHUD.showError("\(error.localizedDescription)")
    }

    func showLoading() {
        ProgressHUD.show()
    }

    func hideLoading() {
        ProgressHUD.dismiss()
    }
    
}

// MARK: - Actions
private extension MyNftViewController {
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func sortAction() {
        let alert = UIAlertController(
            title: nil,
            message: L10n.Profile.sort,
            preferredStyle: .actionSheet
        )
        
        let byPriceAction = UIAlertAction(
            title: L10n.Profile.byPrice,
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            showLoading()
            viewModel.sort(.byPrice)
        }
        
        let byRatingAction = UIAlertAction(
            title: L10n.Profile.byRating,
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            showLoading()
            viewModel.sort(.byRaiting)
        }
        
        let byNameAction = UIAlertAction(
            title: L10n.Profile.byName,
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            showLoading()
            viewModel.sort(.byName)
        }
        
        let close = UIAlertAction(
            title: L10n.Profile.close,
            style: .cancel
        )
        
        alert.addAction(byPriceAction)
        alert.addAction(byRatingAction)
        alert.addAction(byNameAction)
        alert.addAction(close)
        
        present(alert, animated: true)
    }
    
}

// MARK: - UITableViewDelegate
extension MyNftViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

// MARK: - UITableViewDataSource
extension MyNftViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNftTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MyNftTableViewCell
        guard let cell else {
            return UITableViewCell()
        }
        let nft = viewModel.nfts[indexPath.row]
        let isLiked = viewModel.isLiked(nft: nft)
        cell.configure(with: nft, isLiked: isLiked)
        cell.onLike = { [unowned self] in
            showLoading()
            viewModel.like(nft: nft)
        }
        cell.onDislike = { [unowned self] in
            showLoading()
            viewModel.dislike(nft: nft)
        }
        return cell
    }
    
}

