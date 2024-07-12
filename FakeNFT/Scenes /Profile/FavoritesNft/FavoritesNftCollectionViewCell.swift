//
//  FavoritesNftCollectionViewCell.swift
//  FakeNFT
//
//  Created by vs on 21.06.2024.
//

import UIKit
import Kingfisher

final class FavoritesNftCollectionViewCell: UICollectionViewCell {

    static var reuseIdentifier = "FavoritesNftCollectionViewCell"

    private let contentStackView: UIStackView = UIStackView()
    private let infoStackView: UIStackView = UIStackView()
    private let ratingView: ProfileNftRatingView = ProfileNftRatingView()

    private let nftImageView: UIImageView = UIImageView()
    private let nftLikeButton: UIButton = UIButton()
    private let nftNameLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()

    var onLike: (() -> Void)?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        fillMockData()
    }

    func configure(with nft: Nft) {
        nftNameLabel.text = nft.name
        priceLabel.text = "\(nft.price) ETH"
        updateAvatar(url: nft.images.first)
        updateRating(nft.rating)
    }

    private func updateAvatar(url: URL?) {
        let options: KingfisherOptionsInfo = [.scaleFactor(UIScreen.main.scale),
                                              .cacheOriginalImage]
        nftImageView.kf.cancelDownloadTask()
        nftImageView.kf.indicatorType = .activity
        nftImageView.kf.setImage(with: url, placeholder: UIImage.profileAvatarMock, options: options)
    }

    private func updateRating(_ value: Int) {
        ratingView.updateRating(value)
    }

}

private extension FavoritesNftCollectionViewCell {

    func fillMockData() {
        nftImageView.image = .profileAvatarMock
        nftImageView.backgroundColor = .ypGrayUniversal
        nftImageView.layer.masksToBounds = true
        nftImageView.layer.cornerRadius = 12
        nftNameLabel.text = ""
        updateRating(1)
        priceLabel.text = ""
    }

    @objc private func likeAction() {
        onLike?()
    }

    func setupViews() {
        contentView.backgroundColor = .ypWhite
        contentView.addSubview(contentStackView)
        contentView.addSubview(nftLikeButton)

        setupContentStackView()
        setupInfoStackView()

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
            nftLikeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 0)
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

        [nftNameLabel, ratingView, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            infoStackView.addArrangedSubview($0)
        }
        infoStackView.setCustomSpacing(8, after: ratingView)
    }

}
