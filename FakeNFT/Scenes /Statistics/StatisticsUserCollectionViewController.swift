//
//  StatisticsUserCollectionViewController.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 21.06.2024.
//

import UIKit

final class StatisticsUserCollectionViewController: UIViewController {
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .ypBlack
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.text = NSLocalizedString("Statistics.statisticsUserCollection.title", comment: "")
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 64, right: 16)
        collectionView.register(StatisticsCollectionCell.self, forCellWithReuseIdentifier: StatisticsCollectionCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var viewModel: StatisticsUserCollectionViewModelProtocol
    
    // MARK: - Lifecycle
    
    init(viewModel: StatisticsUserCollectionViewModelProtocol) {
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
        viewModel.getData()
    }
    
    private func setupViewController() {
        view.backgroundColor = .ypWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.titleView = titleLabel
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [backButton, titleLabel, collectionView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        viewModel.updateData = { [weak self] update in
            guard let self, update else { return }
            self.collectionView.reloadData()
        }
        viewModel.updateNft = { [weak self] item in
            guard let self else { return }
            let indexPath = IndexPath(item: item, section: 0)
            self.collectionView.reloadItems(at: [indexPath])
            if let cell = self.collectionView.cellForItem(at: indexPath) as? StatisticsCollectionCell {
                cell.inCart = viewModel.inCart(id: cell.nft?.id ?? "")
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension StatisticsUserCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionCell.reuseIdentifier, for: indexPath)
        guard let cell = cell as? StatisticsCollectionCell else {
            return UICollectionViewCell()
        }
        if let model = viewModel.model(at: indexPath) as? StatisticsNft {
            cell.nft = model
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StatisticsUserCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 108, height: 192)
    }
}
