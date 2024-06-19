import Foundation
import Kingfisher
import UIKit

final class CartViewControllerCell: UITableViewCell {
    
    //MARK: - Properties
    
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
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var ratingImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Цена"
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private lazy var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 17, weight: .bold)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private func
    
    private func addElements() {
        [nftImage, nftNameLabel, ratingImage, priceTitleLabel, nftPriceLabel, deleteNftButton].forEach {
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
            nftNameLabel.widthAnchor.constraint(equalToConstant: 68),
            
            ratingImage.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            ratingImage.topAnchor.constraint(equalTo: nftNameLabel.bottomAnchor, constant: 4),
            ratingImage.heightAnchor.constraint(equalToConstant: 12),
            ratingImage.widthAnchor.constraint(equalToConstant: 68),
            
            priceTitleLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            priceTitleLabel.bottomAnchor.constraint(equalTo: nftPriceLabel.topAnchor, constant: -2),
            priceTitleLabel.heightAnchor.constraint(equalToConstant: 18),
            priceTitleLabel.widthAnchor.constraint(equalToConstant: 75),
            
            nftPriceLabel.leadingAnchor.constraint(equalTo: nftNameLabel.leadingAnchor),
            nftPriceLabel.bottomAnchor.constraint(equalTo: nftImage.bottomAnchor, constant: -8),
            nftPriceLabel.heightAnchor.constraint(equalToConstant: 22),
            nftPriceLabel.widthAnchor.constraint(equalToConstant: 75),
            
            deleteNftButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteNftButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deleteNftButton.heightAnchor.constraint(equalToConstant: 40),
            deleteNftButton.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    private func loadAvatar(url: URL) {
        nftImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 12)
        nftImage.kf.setImage(
            with: url,
            placeholder: .none,
            options: [.processor(processor)])
    }
    
    private func setRatingImage(rating: Int) {
        switch rating {
        case 1: ratingImage.image = UIImage(named: "rating_1")
        case 2: ratingImage.image = UIImage(named: "rating_2")
        case 3: ratingImage.image = UIImage(named: "rating_3")
        case 4: ratingImage.image = UIImage(named: "rating_4")
        case 5: ratingImage.image = UIImage(named: "rating_5")
        default: ratingImage.image = UIImage(named: "rating_1")?.withTintColor(.yaLightGrayLight, renderingMode: .automatic)
        }
    }
    
    @objc private func deleteNftButtonTapped() {
        print("Кнопка удаления товара нажата")
    }
    
    
    // MARK: - Internal func
    
    func configure(nft: Nft) {
        guard let url = nft.images.first else { return }
        loadAvatar(url: url)
        setRatingImage(rating: nft.rating)
        nftNameLabel.text = nft.name
        nftPriceLabel.text = "\(nft.price) ETH"
    }
    
}
