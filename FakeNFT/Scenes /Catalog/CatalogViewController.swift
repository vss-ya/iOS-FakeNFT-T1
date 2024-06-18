//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit

final class CatalogViewController: UIViewController {
    
    private let viewModel: CatalogViewModelProtocol
    
    private lazy var tableView = UITableView()
    
    init(viewModel: CatalogViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

private extension CatalogViewController {
    func setupView() {
        view.backgroundColor = .white
        addTableView()
        configTableView()
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
        tableView.rowHeight = 186
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.register(CatalogTableViewCell.self, forCellReuseIdentifier: CatalogTableViewCell.reuseIdentifier)
    }
}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCollectionsNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CatalogTableViewCell.reuseIdentifier) as? CatalogTableViewCell
        else {
            return UITableViewCell()
        }
        let collections = viewModel.getCollections()
        cell.configCell(collections, indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let catalog = viewModel.getCollections()
        let collection = CollectionSettings(
            collectionCover: catalog[indexPath.row].cover,
            collectionName: catalog[indexPath.row].name,
            collectionAuthor: catalog[indexPath.row].author,
            collectionDescription: catalog[indexPath.row].description)
        let viewController = CollectionViewController(collectionSettings: collection, viewModel: CollectionViewModel())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    
}
