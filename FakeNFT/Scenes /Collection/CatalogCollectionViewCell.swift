//
//  CatalogCollectionViewCell.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit
import Kingfisher

final class CatalogCollectionViewCell: UICollectionViewCell {
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favourites_default"), for: .normal)
        return button
    }()
    
    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var ratingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "0star")
        return imageView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
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
        button.setImage(UIImage(named: "cart_add"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CatalogCollectionViewCell {
    
    func setupCell() {
        addSubView()
        addLayout()
        addTarget()
    }
    
    func addSubView() {
        [nftImage,
         ratingImage,
         nftNameLabel,
         nftPriceLabel,
         likeButton,
         cartButton
        ].forEach {
            contentView.addSubview($0)
        }
    }
    
    func addLayout() {
        [nftImage,
         ratingImage,
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
            
            ratingImage.topAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: 8),
            ratingImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            nftNameLabel.topAnchor.constraint(equalTo: ratingImage.bottomAnchor, constant: 5),
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
        likeButton.addTarget(self, action: #selector(setLike), for: .touchUpInside)
        cartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
    }
    
    @objc
    func setLike() {
        likeButton.setImage(UIImage(named: "favourites_pressed"), for: .normal)
    }
    
    @objc
    func addToCart() {
        cartButton.setImage(UIImage(named: "cart_delete"), for: .normal)
    }
    
}

extension CatalogCollectionViewCell {
    func configCell(_ nfts: [Nft], _ indexPath: IndexPath) {
        let nftImageURL = URL(string: nfts[indexPath.row].images[0])
        let processor = ResizingImageProcessor(
            referenceSize: CGSize(width: 108, height: 108),
            mode: .aspectFill)
        nftImage.kf.setImage(with: nftImageURL, options: [.processor(processor)])
        
        switch nfts[indexPath.row].rating {
        case 0: ratingImage.image = UIImage(named: "0star")
        case 1: ratingImage.image = UIImage(named: "1star")
        case 2: ratingImage.image = UIImage(named: "2stars")
        case 3: ratingImage.image = UIImage(named: "3stars")
        case 4: ratingImage.image = UIImage(named: "4stars")
        case 5: ratingImage.image = UIImage(named: "5stars")
        default: ratingImage.image = UIImage(named: "0star")
        }
        nftNameLabel.text = nfts[indexPath.row].name
        let price = String(nfts[indexPath.row].price)
        nftPriceLabel.text = "\(price) ETH"
    }
}

extension UICollectionViewCell {
    static var cellReuseIdentifier: String {
        return String(describing: self)
    }
}
