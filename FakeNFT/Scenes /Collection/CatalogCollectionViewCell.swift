//
//  CatalogCollectionViewCell.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit
import Kingfisher

protocol CollectionCellDelegate: AnyObject {
    func tapLikeButton(_ nft: String)
    func tapCartButton(_ nft: String)
}


final class CatalogCollectionViewCell: UICollectionViewCell {
    
    private var isLiked: Bool = false
    private var inCart: Bool = false
    private var nft: String?
    
    weak var delegate: CollectionCellDelegate?
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var ratingStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.backgroundColor = .systemBackground
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.font = .bodyBold
        return label
    }()
    
    private lazy var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

//MARK: - Cell Properties
private extension CatalogCollectionViewCell {
    
    func setupCell() {
        addSubView()
        addLayout()
        addTarget()
        contentView.backgroundColor = .systemBackground
    }
    
    func addSubView() {
        [nftImage,
         ratingStack,
         nftNameLabel,
         nftPriceLabel,
         likeButton,
         cartButton,
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func addLayout() {
        [nftImage,
         ratingStack,
         nftNameLabel,
         nftPriceLabel,
         likeButton,
         cartButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nftImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            nftImage.heightAnchor.constraint(equalToConstant: 108),
            nftImage.widthAnchor.constraint(equalToConstant: 108),
            
            likeButton.topAnchor.constraint(equalTo: nftImage.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: nftImage.trailingAnchor),
            
            ratingStack.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            ratingStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            nftNameLabel.topAnchor.constraint(equalTo: ratingStack.bottomAnchor, constant: 5),
            nftNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftNameLabel.widthAnchor.constraint(equalToConstant: 68),
            
            nftPriceLabel.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
            nftPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftPriceLabel.widthAnchor.constraint(equalToConstant: 68),
            
            cartButton.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 24),
            cartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cartButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 68),
        ])
    }
    
    func  addTarget() {
        likeButton.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(tapCartButton), for: .touchUpInside)
    }
    
    @objc
    func tapLikeButton() {
        isLiked.toggle()
        setLike(isLiked)
        guard let nft = nft else { return }
        delegate?.tapLikeButton(nft)
    }
    
    @objc
    func tapCartButton() {
        inCart.toggle()
        setCart(inCart)
        guard let nft = nft else { return }
        delegate?.tapCartButton(nft)
    }
    
}

//MARK: - Cell functions
extension CatalogCollectionViewCell {
    func configCell(_ nft: Nft, _ isLiked: Bool, _ inCart: Bool) {
        let nftImageURL = URL(string: nft.images[0])
        let processor = ResizingImageProcessor(
            referenceSize: CGSize(width: 108, height: 108),
            mode: .aspectFill)
        let rating = nft.rating
        let price = String(nft.price)
        self.isLiked = isLiked
        self.inCart = inCart
        self.nft = nft.id
        
        nftImage.kf.setImage(with: nftImageURL, options: [.processor(processor)])
        nftNameLabel.text = nft.name
        nftPriceLabel.text = "\(price) ETH"
        setRating(rating)
        setLike(isLiked)
        setCart(inCart)
    }
    
    
    func setRating(_ rating: Int) {
        let maxRating = CatalogConstants.maxRating
        for number in 0..<maxRating {
            let ratingImage = UIImageView()
            ratingStack.addArrangedSubview(ratingImage)
            switch number < rating {
            case true: ratingImage.image = UIImage(named: CatalogImages.starActive)
            case false: ratingImage.image = UIImage(named: CatalogImages.starNoActive)
            }
        }
    }
    
    func setLike(_ isLiked: Bool) {
        likeButton.setImage(UIImage(named: isLiked ? CatalogImages.favouritesPressed : CatalogImages.favorites ), for: .normal)
    }
    
    func setCart(_ inCart: Bool) {
        cartButton.setImage(UIImage(named: inCart ? CatalogImages.delFromCart : CatalogImages.addToCart), for: .normal)
    }
    
}

extension UICollectionViewCell {
    static var cellReuseIdentifier: String {
        return String(describing: self)
    }
}
