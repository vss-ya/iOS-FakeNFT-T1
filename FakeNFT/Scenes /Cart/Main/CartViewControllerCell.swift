import Foundation
import Kingfisher
import UIKit

final class CartViewControllerCell: UITableViewCell, ReuseIdentifying {
    
    // MARK: - Properties
    
    var deleteButtonAction: ((UIImage) -> Void)?
    
    private lazy var nftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .bodyBold
        return label
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBackground
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.CartCell.price
        label.textColor = .textPrimary
        label.font = .caption2
        return label
    }()
    
    private lazy var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .bodyBold
        return label
    }()
    
    private lazy var deleteNftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cart_delete"), for: .normal)
        button.addTarget(self, action: #selector(deleteNftButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addElements()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for view in ratingStackView.arrangedSubviews {
            ratingStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    // MARK: - Private func
    
    private func addElements() {
        [nftImage, nftNameLabel, ratingStackView, priceTitleLabel, nftPriceLabel, deleteNftButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nftImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nftImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            nftImage.widthAnchor.constraint(equalTo: nftImage.heightAnchor),
            
            nftNameLabel.leadingAnchor.constraint(equalTo: nftImage.trailingAnchor, constant: 20),
            nftNameLabel.topAnchor.constraint(equalTo: nftImage.topAnchor, constant: 8),
            nftNameLabel.heightAnchor.constraint(equalToConstant: 22),
            nftNameLabel.widthAnchor.constraint(equalToConstant: 168),
            
            ratingStackView.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            ratingStackView.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
            ratingStackView.heightAnchor.constraint(equalToConstant: 12),
            ratingStackView.widthAnchor.constraint(equalToConstant: 68),
            
            priceTitleLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            priceTitleLabel.bottomAnchor.constraint(equalTo: nftPriceLabel.topAnchor, constant: -2),
            priceTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            priceTitleLabel.widthAnchor.constraint(equalToConstant: 75),
            
            nftPriceLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            nftPriceLabel.bottomAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: -8),
            nftPriceLabel.heightAnchor.constraint(equalToConstant: 22),
            nftPriceLabel.widthAnchor.constraint(equalToConstant: 175),
            
            deleteNftButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteNftButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteNftButton.heightAnchor.constraint(equalToConstant: 40),
            deleteNftButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func loadImage(url: URL) {
        nftImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        nftImage.kf.setImage(
            with: url,
            placeholder: .none,
            options: [.processor(processor)])
    }
    
    private func setRatingStackView(rating: Int) {
        for starNumber in 1...5 {
            let starImage = UIImageView()
            ratingStackView.addArrangedSubview(starImage)
            starImage.image = (starNumber > rating) ? UIImage(named: "star_no_active") : UIImage(named: "star_active")
        }
    }
    
    @objc private func deleteNftButtonTapped() {
        deleteButtonAction?(self.nftImage.image ?? UIImage())
    }
    
    // MARK: - Internal func
    
    func configure(nft: Nft) {
        guard let url = nft.images.first else { return }
        loadImage(url: url)
        setRatingStackView(rating: nft.rating)
        nftNameLabel.text = nft.name
        nftPriceLabel.text = "\(nft.price) ETH"
    }
    
}
