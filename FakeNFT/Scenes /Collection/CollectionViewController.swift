//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit
import Kingfisher

final class CollectionViewController: UIViewController {

    // MARK: - Private Properties
    private let viewModel: CollectionViewModelProtocol

    private let params = CatalogCollectionParams(cellCount: 3, leftInset: 16, rightInset: 16, cellSpacing: 8.9)

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
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
        label.backgroundColor = .systemBackground
        return label
    }()

    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.backgroundColor = .systemBackground
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var collectionAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = .caption2
        label.text = CatalogLocalization.catalogCollectionAuthor
        label.backgroundColor = .systemBackground
        return label
    }()

    private lazy var collectionAuthorLink: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = .caption2
        button.setTitleColor(UIColor(named: "YP Blue Universal"), for: .normal)
        button.addTarget(self, action: #selector(didTapAuthorName), for: .touchUpInside)
        return button
    }()

    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private lazy var collectionDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.font = .caption2
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.scrollDirection = .vertical
        collection.collectionViewLayout = flowLayout
        collection.backgroundColor = .clear
        return collection
    }()

    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }

    // MARK: - Initializers
    init(selectedCollection: String? = nil, viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addLayout()
        configView()
        addCollectionView()
        addNavBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }

}

// MARK: - View Properties
private extension CollectionViewController {

    func addSubViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.constraintEdges(to: view)
        scrollView.addSubview(contentView)

        [collectionAuthorLabel,
         collectionAuthorLink,
         borderView].forEach {
            authorStackView.addArrangedSubview($0)
        }

        [collectionImage,
         collectionNameLabel,
         authorStackView,
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
         authorStackView,
         collectionDescriptionLabel,
         collectionView
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
            contentView.heightAnchor.constraint(equalToConstant: 900),

            collectionImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImage.heightAnchor.constraint(equalToConstant: CGFloat(CatalogConstants.catalogCollectionCoverHeight)),

            collectionNameLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 16),
            collectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            authorStackView.topAnchor.constraint(equalTo: collectionNameLabel.bottomAnchor, constant: 8),
            authorStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            authorStackView.heightAnchor.constraint(equalToConstant: 28),

            collectionAuthorLabel.widthAnchor.constraint(equalToConstant: widthOfString(font: .caption2, text: collectionAuthorLabel.text)),

            collectionDescriptionLabel.topAnchor.constraint(equalTo: authorStackView.bottomAnchor, constant: 5),
            collectionDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            collectionDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            collectionView.topAnchor.constraint(equalTo: collectionDescriptionLabel.bottomAnchor, constant: 24),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func configView() {
        let collection = viewModel.getSelectedCollection()
        guard let cover = collection?.cover.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return }
        guard let author = collection?.author else { return }
        guard let name = collection?.name else { return }
        guard let description = collection?.description else { return }

        let coverURL = URL(string: cover)
        let processor = ResizingImageProcessor(
            referenceSize: CGSize(width: contentView.frame.width, height: Double(CatalogConstants.catalogCollectionCoverHeight)),
            mode: .aspectFill)
        collectionImage.kf.setImage(with: coverURL, options: [.processor(processor)])

        collectionNameLabel.text = name
        collectionAuthorLink.setTitle(author, for: .normal)
        collectionDescriptionLabel.text = description
    }

    func addNavBar() {
        navigationItem.leftBarButtonItem = addBackButton()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    func addBackButton() -> UIBarButtonItem {
        let button = UIButton()
        button.setImage(UIImage(named: CatalogImages.catalogBackButton), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 24),
            button.heightAnchor.constraint(equalToConstant: 24)
        ])

        let backButton = UIBarButtonItem(customView: button)
        return backButton
    }

    @objc
    func backButtonTapped() {
        dismiss(animated: true)
    }

    @objc
    func didTapAuthorName() {
        let url = URL(string: CatalogConstants.catalogAuthorLink)
        let viewController = WebViewController(url: url)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.modalPresentationStyle = .fullScreen
        present(navigationViewController, animated: true)
    }

    func widthOfString(font: UIFont, text: String?) -> CGFloat {
        guard let text = text else { return 0 }
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size.width
    }

    func bind() {
        viewModel.updateCollection = { [weak self] update in
            guard let self = self else { return }
            UIBlockingProgressHUD.dismiss()
            switch update {
            case true: self.collectionView.reloadData()
            case false: do {
                CatalogAlertPresenter.showAlert(delegate: self) {
                    self.viewModel.getData()
                }
            }
            }
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    private func addCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(CatalogCollectionViewCell.self, forCellWithReuseIdentifier: CatalogCollectionViewCell.cellReuseIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsPerRow = params.cellCount
        let availableWidth = collectionView.frame.width - params.paddingWidth
        let cellWidth = availableWidth / CGFloat(cellsPerRow)
        return CGSize(width: cellWidth, height: Double(CatalogConstants.catalogCollectionCellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: params.leftInset, bottom: 0, right: params.rightInset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        params.cellSpacing
    }

}

// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.nftNumber
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CatalogCollectionViewCell.cellReuseIdentifier, for: indexPath) as? CatalogCollectionViewCell else {
            preconditionFailure("Failed to cast UICollectionViewCell as CatalogCollectionViewCell")
        }
        let nft = viewModel.getNft(at: indexPath)
        let isLiked = viewModel.isLiked(nft.id)
        let inCart = viewModel.inCart(nft.id)
        cell.configCell(nft, isLiked, inCart)
        cell.delegate = self
        return cell
    }

}

// MARK: - CollectionCellDelegate
extension CollectionViewController: CollectionCellDelegate {
    func tapLikeButton(_ nft: String) {
        viewModel.didTapLike(nft)
    }

    func tapCartButton(_ nft: String) {
        viewModel.didTapCart(nft)
    }
}
