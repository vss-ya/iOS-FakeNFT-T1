//
//  CatalogTableViewCell.swift
//  FakeNFT
//
//  Created by Anton Filipchuk on 18.06.2024.
//

import UIKit
import Kingfisher

final class CatalogTableViewCell: UITableViewCell {

    private lazy var collectionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension CatalogTableViewCell {

    func setupCell() {
        backgroundColor = .systemBackground
        addLayout()
    }

    func addLayout() {
        [collectionImage,
         collectionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            collectionImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionImage.heightAnchor.constraint(equalToConstant: CGFloat(CatalogConstants.catalogCoverHeight)),

            collectionLabel.topAnchor.constraint(equalTo: collectionImage.bottomAnchor, constant: 4),
            collectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}

extension CatalogTableViewCell {
    func configCell(_ catalog: Catalog) {
        guard let encodedString = catalog.cover.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
              let collectionCoverURL = URL(string: encodedString) else { return }
        let processor = ResizingImageProcessor(
            referenceSize: CGSize(width: self.contentView.frame.width, height: Double(CatalogConstants.catalogCoverHeight)),
            mode: .aspectFill)
        self.collectionImage.kf.setImage(with: collectionCoverURL, options: [.processor(processor)])
        let collectionName = catalog.name
        let collectionCount = catalog.nfts.count
        self.collectionLabel.text = "\(collectionName) (\(collectionCount))"
    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
