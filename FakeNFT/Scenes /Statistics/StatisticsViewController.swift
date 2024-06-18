//
//  StatisticsViewController.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit

final class StatisticsViewController: UIViewController {
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "sort"), for: .normal)
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = false
        tableView.register(StatisticsCell.self, forCellReuseIdentifier: StatisticsCell.reuseIdentifier)
        return tableView
    }()
    
    
    private var viewModel: StatisticsCollectionsViewModelProtocol?
    
    // MARK: - Lifecycle
    
    func applyViewModel(_ newViewModel: StatisticsCollectionsViewModelProtocol) {
        viewModel = newViewModel
        bind()
        viewModel?.initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        view.backgroundColor = .ypWhite
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: sortButton)
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [sortButton, tableView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel?.updateData = { [weak self] update in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    // MARK: - Actions
    
    @objc private func didTapSortButton() {
        AlertPresenter.statisticsSort(delegate: self) { byName in
            
        }
    }
}

// MARK: - UITableViewDataSource

extension StatisticsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.reuseIdentifier, for: indexPath)
        guard let cell = cell as? StatisticsCell, let model = viewModel?.model(at: indexPath) as? StatisticsProfile else {
            return UITableViewCell()
        }
        cell.profile = model
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel?.model(at: indexPath) as? StatisticsProfile else { return }
        let statisticsProfileViewController = StatisticsProfileViewController()
        statisticsProfileViewController.profile = model
        
        let statisticsProfileNavigationController = UINavigationController(rootViewController: statisticsProfileViewController)
        statisticsProfileNavigationController.modalPresentationStyle = .overCurrentContext
        
        self.present(statisticsProfileNavigationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
