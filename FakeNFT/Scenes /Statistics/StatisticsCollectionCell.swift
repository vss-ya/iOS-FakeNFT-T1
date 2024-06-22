//
//  StatisticsCollectionCell.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 21.06.2024.
//

import UIKit
import Kingfisher

final class StatisticsCollectionCell: UICollectionViewCell {
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        imageView.tintColor = .ypLightGrey
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "favourites_default"), for: .normal)
        return button
    }()
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var rating1ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starNoActive
        return imageView
    }()
    private lazy var rating2ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starNoActive
        return imageView
    }()
    private lazy var rating3ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starNoActive
        return imageView
    }()
    private lazy var rating4ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starNoActive
        return imageView
    }()
    private lazy var rating5ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .starNoActive
        return imageView
    }()
    private lazy var descStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    private lazy var descVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    private lazy var cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "cart_add"), for: .normal)
        button.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
        return button
    }()
    
    static let reuseIdentifier = "statisticsCollectionCell"
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        nftImageView.kf.setImage(
            with: URL(string: ""),
            placeholder: UIImage(systemName: "xmark.icloud"),
            options: [.processor(processor)]
        )
        nameLabel.text = "Toast"
        priceLabel.text = "1,78 ETH"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [nftImageView, likeButton, ratingStackView, descStackView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
        [rating1ImageView, rating2ImageView, rating3ImageView, rating4ImageView, rating5ImageView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            ratingStackView.addSubview(subview)
        }
        [descVerticalStackView, cartButton].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            descStackView.addSubview(subview)
        }
        [nameLabel, priceLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            descVerticalStackView.addSubview(subview)
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            nftImageView.topAnchor.constraint(equalTo: self.topAnchor),
            nftImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108)
        ])
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor),
            likeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            ratingStackView.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 8),
            ratingStackView.leadingAnchor.constraint(equalTo: nftImageView.leadingAnchor),
            ratingStackView.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            rating1ImageView.topAnchor.constraint(equalTo: ratingStackView.topAnchor),
            rating1ImageView.leadingAnchor.constraint(equalTo: ratingStackView.leadingAnchor),
            rating1ImageView.widthAnchor.constraint(equalToConstant: 12),
            rating1ImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            rating2ImageView.topAnchor.constraint(equalTo: ratingStackView.topAnchor),
            rating2ImageView.leadingAnchor.constraint(equalTo: rating1ImageView.trailingAnchor, constant: 2),
            rating2ImageView.widthAnchor.constraint(equalToConstant: 12),
            rating2ImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            rating3ImageView.topAnchor.constraint(equalTo: ratingStackView.topAnchor),
            rating3ImageView.leadingAnchor.constraint(equalTo: rating2ImageView.trailingAnchor, constant: 2),
            rating3ImageView.widthAnchor.constraint(equalToConstant: 12),
            rating3ImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            rating4ImageView.topAnchor.constraint(equalTo: ratingStackView.topAnchor),
            rating4ImageView.leadingAnchor.constraint(equalTo: rating3ImageView.trailingAnchor, constant: 2),
            rating4ImageView.widthAnchor.constraint(equalToConstant: 12),
            rating4ImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            rating5ImageView.topAnchor.constraint(equalTo: ratingStackView.topAnchor),
            rating5ImageView.leadingAnchor.constraint(equalTo: rating4ImageView.trailingAnchor, constant: 2),
            rating5ImageView.widthAnchor.constraint(equalToConstant: 12),
            rating5ImageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        NSLayoutConstraint.activate([
            descStackView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor, constant: 8),
            descStackView.leadingAnchor.constraint(equalTo: ratingStackView.leadingAnchor),
            descStackView.trailingAnchor.constraint(equalTo: ratingStackView.trailingAnchor),
            descStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            cartButton.topAnchor.constraint(equalTo: descStackView.topAnchor),
            cartButton.trailingAnchor.constraint(equalTo: descStackView.trailingAnchor),
            cartButton.widthAnchor.constraint(equalToConstant: 40),
            cartButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            descVerticalStackView.topAnchor.constraint(equalTo: descStackView.topAnchor),
            descVerticalStackView.bottomAnchor.constraint(equalTo: descStackView.bottomAnchor),
            descVerticalStackView.leadingAnchor.constraint(equalTo: descStackView.leadingAnchor),
            descVerticalStackView.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: descVerticalStackView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: descVerticalStackView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: descVerticalStackView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            priceLabel.bottomAnchor.constraint(equalTo: descVerticalStackView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: descVerticalStackView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: descVerticalStackView.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapCartButton() {

    }
}
