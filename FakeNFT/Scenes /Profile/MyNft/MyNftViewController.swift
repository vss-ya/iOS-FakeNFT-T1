//
//  MyNftViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit

final class MyNftViewController: UIViewController {
    
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .ypWhite
        tableView.register(MyNftTableViewCell.self,
                           forCellReuseIdentifier: MyNftTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
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
    }
    
}

// MARK: - Helpers
private extension MyNftViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        title = L10n.Profile.myNft
        navigationItem.leftBarButtonItem = .init(customView: backButton)
        navigationItem.rightBarButtonItem = .init(customView: sortButton)
        view.backgroundColor = .ypWhite
        
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
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
        }
        
        let byRatingAction = UIAlertAction(
            title: L10n.Profile.byRating,
            style: .default
        ) { [weak self] _ in
        }
        
        let byNameAction = UIAlertAction(
            title: L10n.Profile.byName,
            style: .default
        ) { [weak self] _ in
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyNftTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MyNftTableViewCell
        guard let cell else {
            return UITableViewCell()
        }
        return cell
    }
    
}

