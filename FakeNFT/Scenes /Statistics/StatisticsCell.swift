//
//  StatisticsCell.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit
import Kingfisher

final class StatisticsCell: UITableViewCell {
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private lazy var backgroundLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.backgroundColor = .ypLightGrey
        return label
    }()
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        imageView.tintColor = .ypGrayUniversal
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    private lazy var nftsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .ypBlack
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .right
        return label
    }()
    
    var user: StatisticsUser? {
        didSet {
            guard let user else { return }
            ratingLabel.text = user.rating
            if let url = URL(string: user.avatar) {
                let processor = RoundCornerImageProcessor(cornerRadius: 14)
                avatarImageView.kf.setImage(
                    with: url,
                    placeholder: UIImage(systemName: "person.crop.circle.fill"),
                    options: [.processor(processor)]
                )
            } else {
                avatarImageView.image = UIImage(systemName: "person.crop.circle.fill")
            }
            nameLabel.text = user.name
            nftsLabel.text = String(user.nfts.count)
        }
    }
    
    static let reuseIdentifier = "statisticsCell"
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [ratingLabel, backgroundLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
        [avatarImageView, nameLabel, nftsLabel].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            backgroundLabel.addSubview(subview)
        }
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ratingLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 27),
            ratingLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            backgroundLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8),
            backgroundLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            backgroundLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: backgroundLabel.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 28),
            avatarImageView.heightAnchor.constraint(equalToConstant: 28)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: nftsLabel.leadingAnchor, constant: -8),
        ])
        NSLayoutConstraint.activate([
            nftsLabel.trailingAnchor.constraint(equalTo: backgroundLabel.trailingAnchor, constant: -16),
            nftsLabel.centerYAnchor.constraint(equalTo: backgroundLabel.centerYAnchor),
            nftsLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
}
