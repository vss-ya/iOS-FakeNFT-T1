import Foundation
import Kingfisher
import UIKit

final class CurrencyCell: UICollectionViewCell, ReuseIdentifying {

    // MARK: - Properties

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .caption2
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var shortNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .yaGreenUniversal
        label.font = .caption2
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .yaBlackUniversal
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .yaLightGrayLight
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        addElements()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Private func

    private func addElements() {
        [blackView, fullNameLabel, shortNameLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        blackView.addSubview(logoImageView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            blackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            blackView.heightAnchor.constraint(equalToConstant: 36),
            blackView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

            logoImageView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 31.5),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

            fullNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 4),
            fullNameLabel.topAnchor.constraint(equalTo: logoImageView.topAnchor),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18),

            shortNameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 4),
            shortNameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            shortNameLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func loadImage(url: URL) {
        logoImageView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 6)
        logoImageView.kf.setImage(
            with: url,
            placeholder: .none,
            options: [.processor(processor)])
    }

    // MARK: - Internal func

    func configure(currency: Currency) {
        guard let url = URL(string: currency.image) else { return }
        loadImage(url: url)
        fullNameLabel.text = currency.title
        shortNameLabel.text = currency.name
    }

}
