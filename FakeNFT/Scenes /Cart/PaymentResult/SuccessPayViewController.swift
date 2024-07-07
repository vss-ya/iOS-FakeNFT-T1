import Foundation
import UIKit

final class SuccessPayViewController: UIViewController {

    // MARK: - Properties

    private lazy var successImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "success_image"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textPrimary
        label.font = .headline3
        label.text = "Успех! Оплата прошла, поздравляем с покупкой!"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()

    private lazy var goToCatalogButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yaBlackLight
        button.setTitle("Вернуться в каталог", for: .normal)
        button.titleLabel?.font = .bodyBold
        button.setTitleColor(.primary, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(returnToCatalogButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        addElements()
        setConstraints()
    }

    // MARK: - Private Function

    private func addElements() {
        [successImage, successLabel, goToCatalogButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            successImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 196),
            successImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 49),
            successImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -49),
            successImage.heightAnchor.constraint(equalTo: successImage.widthAnchor),

            successLabel.topAnchor.constraint(equalTo: successImage.bottomAnchor, constant: 20),
            successLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            successLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),

            goToCatalogButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            goToCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            goToCatalogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goToCatalogButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    // MARK: - Actions

    @objc private func returnToCatalogButtonTapped() {
        let servicesAssembly = ServicesAssembly(
            networkClient: DefaultNetworkClient(),
            nftStorage: NftStorageImpl()
        )
        let tabBarController = TabBarController(servicesAssembly: servicesAssembly)
        tabBarController.returnToCatalog()
        let navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}
