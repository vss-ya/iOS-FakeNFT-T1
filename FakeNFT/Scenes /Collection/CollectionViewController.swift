//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit
import Kingfisher

final class CollectionViewController: UIViewController {
    
    var collectionSettings: CollectionSettings?
    
    private let viewModel: CollectionViewModelProtocol
    private let params = CatalogCollectionParams(cellCount: 3, leftInset: 16, rightInset: 16, cellSpacing: 9)
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentSize
        return view
    }()
    
    private lazy var collectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return imageView
    }()
    
    private lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .headline3
        return label
    }()
    
    private lazy var collectionAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        return label
    }()
    
    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    init(collectionSettings: CollectionSettings? = nil, viewModel: CollectionViewModelProtocol) {
        self.collectionSettings = collectionSettings
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addLayout()
        configView()
        addCollectionView()
    }
    
}

private extension CollectionViewController {
    
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [collectionImage,
         collectionNameLabel,
         collectionAuthorLabel,
         collectionDescriptionLabel,
         collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func addLayout() {
        [scrollView,
         contentView,
         collectionImage,
         collectionNameLabel,
         collectionAuthorLabel,
         collectionDescriptionLabel,
         collectionView,
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            collectionImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImage.heightAnchor.constraint(equalToConstant: 310),
            
            collectionNameLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionAuthorLabel.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 8),
            collectionAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionDescriptionLabel.topAnchor.constraint(equalTo: collectionAuthorLabel.bottomAnchor, constant: 5),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: collectionDescriptionLabel.bottomAnchor, constant: 24),
            collectionView.heightAnchor.constraint(equalToConstant: heightOfCollectionView()),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configView() {
        guard let cover = collectionSettings?.collectionCover else { return }
        guard let author = collectionSettings?.collectionAuthor else { return }
        guard let name = collectionSettings?.collectionName else { return }
        guard let description = collectionSettings?.collectionDescription else { return }
        
        let coverURL = URL(string: cover)
        let processor = ResizingImageProcessor(
            referenceSize: CGSize(width: contentView.frame.width, height: 310),
            mode: .aspectFill)
        collectionImage.kf.setImage(with: coverURL, options: [.processor(processor)])
        
        collectionNameLabel.text = name
        collectionAuthorLabel.text = "Автор коллекции: \(author)"
        collectionDescriptionLabel.text = description
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    private func addCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCollectionViewCell.cellReuseIdentifier)
    }
    
    private func heightOfCollectionView() -> CGFloat {
        let numberOfNft = viewModel.getNftNumber()
        var numbersOfRows = numberOfNft % params.cellCount
        switch numbersOfRows {
        case 0: do {
            numbersOfRows = numberOfNft / params.cellCount
        }
        default: do {
            numbersOfRows = (numberOfNft / params.cellCount) + 1
        }
        }
        let hight = numbersOfRows * 192
        return CGFloat(hight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = params.cellCount
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableWidth / CGFloat(cellsPerRow)
        return CGSize(width: cellWidth , height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: params.leftInset, bottom: 0, right: params.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }
    
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNftNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.cellReuseIdentifier, for: indexPath) as? CatalogCollectionViewCell else {
            preconditionFailure("Failed to cast UICollectionViewCell as CatalogCollectionViewCell")
        }
        let nfts = viewModel.getNfts()
        cell.configCell(nfts, indexPath)
        return cell
        
    }
    
    
}
