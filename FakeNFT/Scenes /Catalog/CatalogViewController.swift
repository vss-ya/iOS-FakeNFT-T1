//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    private var viewModel: CatalogViewModelProtocol
    
    private lazy var tableView = UITableView()
    
    init(viewModel: CatalogViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
}

//MARK: - View Properies
private extension CatalogViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addTableView()
        configTableView()
        addNavBar()
    }
    
    func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func configTableView() {
        tableView.rowHeight = CGFloat(CatalogConstants.catalogTableRowHeight)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorColor = .clear
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.reuseIdentifier)
    }
    
    func addNavBar() {
        navigationItem.rightBarButtonItem = addSortButton()
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    func addSortButton() -> UIBarButtonItem {
        let button = UIButton()
        button.setImage(UIImage(named: CatalogImages.catalogSortButton), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 42),
            button.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        let sortButton = UIBarButtonItem(customView: button)
        return sortButton
    }
    
    @objc
    func sortButtonTapped() {
        let alert = UIAlertController(
            title: "",
            message: CatalogLocalization.catalogSortMessage,
            preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: CatalogLocalization.catalogSortByName, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sortByName()
            self.tableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: CatalogLocalization.catalogSortByNftCount, style: .default, handler: { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.sortByNftCount()
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: CatalogLocalization.catalogSortCancel, style: .cancel))
        self.present(alert, animated: true)
    }
    
    func bind() {
        viewModel.updateData = { [weak self] update in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCollectionsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.reuseIdentifier) as? CatalogTableViewCell
        else {
            return UITableViewCell()
        }
        let collection = viewModel.collection(at: indexPath)
        cell.configCell(collection)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let collection = viewModel.collection(at: indexPath)
        let id = collection.id
        let viewController = CollectionViewController(viewModel: CollectionViewModel(selectedCollection: id))
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true)
    }
    
    
}
