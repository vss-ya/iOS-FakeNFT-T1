import Foundation
import UIKit

final class ConfirmDeleteViewController: UIViewController {

    private let image: UIImage
    private let viewModel: CartViewModel
    private let id: String

    private lazy var confirmationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .caption2
        label.text = L10n.NftRemoval.messageLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yaBlackLight
        button.setTitle(L10n.NftRemoval.deleteButton, for: .normal)
        button.setTitleColor(.yaRedUniversal, for: .normal)
        button.titleLabel?.font = .bodyRegular
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yaBlackLight
        button.setTitle(L10n.NftRemoval.cancelButton, for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.titleLabel?.font = .bodyRegular
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    init(image: UIImage, viewModel: CartViewModel, id: String) {
        self.image = image
        self.viewModel = viewModel
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBlurEffect()
        addElements()
        setConstraints()
        nftImageView.image = image
    }

    private func setupBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }

    private func addElements() {
        view.addSubview(confirmationView)
        [nftImageView, messageLabel, deleteButton, cancelButton].forEach {
            confirmationView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            confirmationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            confirmationView.widthAnchor.constraint(equalToConstant: 262),
            confirmationView.heightAnchor.constraint(equalToConstant: 220),

            nftImageView.topAnchor.constraint(equalTo: confirmationView.topAnchor),
            nftImageView.centerXAnchor.constraint(equalTo: confirmationView.centerXAnchor),
            nftImageView.widthAnchor.constraint(equalToConstant: 108),
            nftImageView.heightAnchor.constraint(equalToConstant: 108),

            messageLabel.topAnchor.constraint(equalTo: nftImageView.bottomAnchor, constant: 12),
            messageLabel.centerXAnchor.constraint(equalTo: confirmationView.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 180),
            messageLabel.heightAnchor.constraint(equalToConstant: 36),

            deleteButton.leadingAnchor.constraint(equalTo: confirmationView.leadingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: confirmationView.bottomAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 127),
            deleteButton.heightAnchor.constraint(equalToConstant: 44),

            cancelButton.trailingAnchor.constraint(equalTo: confirmationView.trailingAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: confirmationView.bottomAnchor),
            cancelButton.widthAnchor.constraint(equalTo: deleteButton.widthAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc func deleteButtonTapped() {
        viewModel.deleteNftFromOrder(id: self.id)
        dismiss(animated: true)
    }

    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }

}
