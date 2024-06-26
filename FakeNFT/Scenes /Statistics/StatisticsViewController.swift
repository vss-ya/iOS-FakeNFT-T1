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
    
    private var sortField: StatisticsSortFields = .byRating
    
    private var viewModel: StatisticsViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: StatisticsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIBlockingProgressHUD.animate()
        viewModel.getData(sortField: sortField)
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
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.updateData = { [weak self] update in
            UIBlockingProgressHUD.dismiss()
            guard let self else { return }
            if update {
                self.tableView.reloadData()
            } else {
                AlertPresenter.loadDataError(delegate: self) {
                    UIBlockingProgressHUD.animate()
                    self.viewModel.getData(sortField: self.sortField)
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapSortButton() {
        AlertPresenter.statisticsSort(delegate: self) { [weak self] sortField in
            UIBlockingProgressHUD.animate()
            self?.sortField = sortField
            self?.viewModel.getData(sortField: sortField)
        }
    }
}

// MARK: - UITableViewDataSource

extension StatisticsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.reuseIdentifier, for: indexPath)
        guard let cell = cell as? StatisticsCell, let model = viewModel.model(at: indexPath) as? StatisticsUser else {
            return UITableViewCell()
        }
        cell.user = model
        return cell
    }
}

// MARK: - UITableViewDelegate

extension StatisticsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.model(at: indexPath) as? StatisticsUser else { return }
        let statisticsUserViewController = StatisticsUserViewController(viewModel: StatisticsUserViewModel(id: model.id))
        statisticsUserViewController.dismissClosure = { [weak self] in
            self?.tabBarController?.tabBar.isHidden = false
        }
        
        let statisticsUserNavigationController = UINavigationController(rootViewController: statisticsUserViewController)
        statisticsUserNavigationController.modalPresentationStyle = .overCurrentContext
        
        self.present(statisticsUserNavigationController, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
