//
//  MyNftTableViewCell.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit
import Kingfisher

final class MyNftTableViewCell: UITableViewCell {

    private let contentStackView: UIStackView = UIStackView()
    private let infoStackView: UIStackView = UIStackView()
    private let ratingView: ProfileNftRatingView = ProfileNftRatingView()
    private let fromStackView: UIStackView = UIStackView()
    private let priceStackView: UIStackView = UIStackView()

    private let nftImageView: UIImageView = UIImageView()
    private let nftLikeButton: UIButton = UIButton()
    private let nftNameLabel: UILabel = UILabel()
    private let fromLabel: UILabel = UILabel()
    private let fromNameLabel: UILabel = UILabel()
    private let priceTitleLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()

    private var isLiked: Bool = false

    var onLike: ((Bool) -> Void)?

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .ypWhite
        selectionStyle = .none

        setupViews()
        fillMockData()
    }

    func configure(with nft: Nft, isLiked: Bool) {
        self.isLiked = isLiked

        nftNameLabel.text = nft.name
        fromNameLabel.text = nft.author
        priceLabel.text = "\(nft.price) ETH"
        nftLikeButton.setImage(isLiked ? .profileLikeActive : .profileLikeNoActive, for: .normal)
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

private extension MyNftTableViewCell {

    func fillMockData() {
        nftImageView.image = .profileAvatarMock
        nftImageView.backgroundColor = .ypGrayUniversal
        nftImageView.layer.masksToBounds = true
        nftImageView.layer.cornerRadius = 12
        nftNameLabel.text = ""
        updateRating(1)
        fromNameLabel.text = ""
        priceLabel.text = ""
    }

    @objc private func likeAction() {
        onLike?(!isLiked)
    }

    func setupViews() {
        contentView.backgroundColor = .ypWhite
        contentView.addSubview(contentStackView)
        contentView.addSubview(nftLikeButton)

        setupContentStackView()
        setupInfoStackView()
        setupFromStackView()
        setupPriceStackView()

        nftImageView.layer.masksToBounds = true
        nftImageView.layer.cornerRadius = 12
        nftLikeButton.translatesAutoresizingMaskIntoConstraints = false
        nftLikeButton.setImage(.profileLikeActive, for: .normal)
        nftLikeButton.addTarget(self, action: #selector(likeAction), for: .touchUpInside)
        nftNameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nftNameLabel.textColor = .ypBlack
        fromLabel.font = .systemFont(ofSize: 15, weight: .regular)
        fromLabel.textColor = .ypBlack
        fromLabel.text = L10n.Profile.from
        fromNameLabel.font = .systemFont(ofSize: 13, weight: .regular)
        fromNameLabel.textColor = .ypBlack
        priceTitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        priceTitleLabel.textColor = .ypBlack
        priceTitleLabel.text = L10n.Profile.price
        priceLabel.font = .systemFont(ofSize: 17, weight: .bold)
        priceLabel.textColor = .ypBlack
        priceLabel.minimumScaleFactor = 0.5
        priceLabel.adjustsFontSizeToFitWidth = true

        nftNameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        nftNameLabel.setContentCompressionResistancePriority(.init(749), for: .horizontal)
        fromNameLabel.setContentHuggingPriority(.init(249), for: .horizontal)
        fromNameLabel.setContentCompressionResistancePriority(.init(749), for: .horizontal)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),
            priceStackView.widthAnchor.constraint(equalToConstant: 75),
            nftLikeButton.topAnchor.constraint(equalTo: nftImageView.topAnchor, constant: 0),
            nftLikeButton.trailingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 0)
        ])
    }

    func setupContentStackView() {
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .fill
        contentStackView.spacing = 20
        contentStackView.translatesAutoresizingMaskIntoConstraints = false

        [nftImageView, infoStackView, priceStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentStackView.addArrangedSubview($0)
        }
    }

    func setupInfoStackView() {
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .fill
        infoStackView.spacing = 4

        [nftNameLabel, ratingView, fromStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            infoStackView.addArrangedSubview($0)
        }
    }

    func setupFromStackView() {
        fromStackView.axis = .horizontal
        fromStackView.alignment = .fill
        fromStackView.distribution = .fill
        fromStackView.spacing = 4

        [fromLabel, fromNameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            fromStackView.addArrangedSubview($0)
        }
    }

    func setupPriceStackView() {
        priceStackView.axis = .vertical
        priceStackView.alignment = .leading
        priceStackView.distribution = .fill
        priceStackView.spacing = 2

        [priceTitleLabel, priceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            priceStackView.addArrangedSubview($0)
        }
    }

}
