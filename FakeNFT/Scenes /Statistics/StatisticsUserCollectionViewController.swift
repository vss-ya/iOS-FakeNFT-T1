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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    private func setupViewController() {
        view.backgroundColor = .ypWhite
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [backButton, collectionView].forEach { subview in
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
    
    // MARK: - Actions
    
    @objc private func didTapBackButton() {
        dismiss(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension StatisticsUserCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionCell.reuseIdentifier, for: indexPath)
        guard let cell = cell as? StatisticsCollectionCell else {
            return UICollectionViewCell()
        }
        //cell.viewModel = viewModel
        //cell.indexPath = indexPath
        //cell.tracker = viewModel.model(at: indexPath)
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
