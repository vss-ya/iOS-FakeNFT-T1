//
//  FavoritesNftViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit

final class FavoritesNftViewController: UIViewController {
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(.profileBack, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = .init(top: 20, left: 16, bottom: 20, right: 16)
        view.register(FavoritesNftCollectionViewCell.self,
                      forCellWithReuseIdentifier: FavoritesNftCollectionViewCell.reuseIdentifier)
        view.allowsMultipleSelection = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let viewModel: FavoritesNftViewModelProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ viewModel: FavoritesNftViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = L10n.Profile.favoritesNft
        navigationItem.leftBarButtonItem = .init(customView: backButton)

        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    }
    
}

// MARK: - Actions
private extension FavoritesNftViewController {
    
    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource
extension FavoritesNftViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FavoritesNftCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? FavoritesNftCollectionViewCell
        guard let cell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

// MARK: - UICollectionViewDelegate
extension FavoritesNftViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FavoritesNftViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = collectionView.bounds.width - 32 - 7
        let cellWidth = viewWidth / 2
        return CGSize(width: cellWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
