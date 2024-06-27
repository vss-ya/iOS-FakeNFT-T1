//
//  FavoritesNftCollectionViewCell.swift
//  FakeNFT
//
//  Created by vs on 21.06.2024.
//

import UIKit

final class FavoritesNftCollectionViewCell: UICollectionViewCell {
    
    static var reuseIdentifier = "FavoritesNftCollectionViewCell"
    
    private let contentStackView: UIStackView = UIStackView()
    private let infoStackView: UIStackView = UIStackView()
    private let starsStackView: UIStackView = UIStackView()
    
    private let nftImageView: UIImageView = UIImageView()
    private let nftLikeButton: UIButton = UIButton()
    private let nftNameLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fillMockData()
    }
    
    private func updateRating(_ value: Int) {
        let value = value < 0 ? 0 : (value > 5 ? 5 : value)
        (0..<value).forEach {
            let view = starsStackView.arrangedSubviews[$0] as? UIImageView
            view?.image = .starActive
        }
        (value..<5).forEach {
            let view = starsStackView.arrangedSubviews[$0] as? UIImageView
            view?.image = .starNoActive
        }
    }
    
}

private extension FavoritesNftCollectionViewCell {
    
    func fillMockData() {
        nftImageView.image = .profileNftMock
        nftNameLabel.text = "Spring"
        updateRating(1)
        priceLabel.text = "1,78 ETH"
    }
    
    @objc private func likeAction() {
    }
    
    func setupViews() {
        contentView.backgroundColor = .ypWhite
        contentView.addSubview(contentStackView)
        contentView.addSubview(nftLikeButton)
        
        setupContentStackView()
        setupInfoStackView()
        setupStarsStackView()
        
        nftImageView.layer.masksToBounds = true
        nftImageView.layer.cornerRadius = 12
        nftLikeButton.translatesAutoresizingMaskIntoConstraints = false
        nftLikeButton.setImage(.profileLikeActive, for: .normal)
        nftLikeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        nftNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nftNameLabel.textColor = .ypBlack
        priceLabel.font = .systemFont(ofSize: 15, weight: .regular)
        priceLabel.textColor = .ypBlack
        priceLabel.minimumScaleFactor = 0.5
        priceLabel.adjustsFontSizeToFitWidth = true
        
        nftNameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        nftNameLabel.setContentCompressionResistancePriority(.init(749), for: .horizontal)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            nftImageView.widthAnchor.constraint(equalToConstant: 80),
            nftImageView.heightAnchor.constraint(equalToConstant: 80),
            nftLikeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 0),
            nftLikeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 0),
        ])
    }
    
    func setupContentStackView() {
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .fill
        contentStackView.spacing = 12
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [nftImageView, infoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentStackView.addArrangedSubview($0)
        }
    }
    
    func setupInfoStackView() {
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .fill
        infoStackView.spacing = 4
        
        [nftNameLabel, starsStackView, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            infoStackView.addArrangedSubview($0)
        }
        infoStackView.setCustomSpacing(8, after: starsStackView)
    }
    
    func setupStarsStackView() {
        starsStackView.axis = .horizontal
        starsStackView.alignment = .fill
        starsStackView.distribution = .fill
        starsStackView.spacing = 2
        
        (0..<5).forEach {
            let view = UIImageView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.accessibilityIdentifier = "star_\($0)"
            view.image = .starNoActive
            starsStackView.addArrangedSubview(view)
        }
    }
    
}
