import Foundation
import UIKit

final class CurrencyViewController: UIViewController, LoadingView, ErrorView {
    
    // MARK: - Properties
    
    private let collectionParams = CollectionParams(
        cellCount: 2,
        height: 46,
        leftInset: 16,
        rightInset: -16,
        cellSpacing: 7
    )
    
    private let currencyViewModel: CurrencyViewModel
    private var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var selectedCurrencyIndex: Int?
    
    private lazy var currencyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 186, right: 0)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CurrencyCell.self)
        return collectionView
    }()
    
    private lazy var paymentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yaLightGrayLight
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var agreementLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.textColor = .textPrimary
        label.font = .caption2
        label.text = L10n.Currency.agreementLabel
        label.textAlignment = .left
        return label
    }()
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.textColor = .yaBlueUniversal
        label.font = .caption2
        label.text = L10n.Currency.termsLabel
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .darkGray
        button.setTitle(L10n.Currency.paymentButton, for: .normal)
        button.titleLabel?.font = .bodyBold
        button.setTitleColor(.primary, for: .normal)
        button.layer.cornerRadius = 16
        button.isEnabled = false
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .yaBlackLight
        return activityIndicator
    }()
    
    // MARK: - Initialization
    
    init(
        currencyViewModel: CurrencyViewModel
    ) {
        self.currencyViewModel = currencyViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        createNavigationBar()
        addElements()
        setConstraints()
        bindViewModel()
        currencyCollectionView.dataSource = self
        currencyCollectionView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTermsLabel))
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Private Function
    
    private func addElements() {
        [currencyCollectionView, paymentContainerView, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [agreementLabel, termsLabel, paymentButton].forEach {
            paymentContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            currencyCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 20),
            currencyCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -186),
            currencyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            currencyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            paymentContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            paymentContainerView.heightAnchor.constraint(equalToConstant: 186),
            paymentContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            agreementLabel.topAnchor.constraint(equalTo: paymentContainerView.topAnchor, constant: 16),
            agreementLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            agreementLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            agreementLabel.heightAnchor.constraint(equalToConstant: 22),
            
            termsLabel.topAnchor.constraint(equalTo: agreementLabel.bottomAnchor),
            termsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            termsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            termsLabel.heightAnchor.constraint(equalToConstant: 22),
            
            paymentButton.topAnchor.constraint(equalTo: termsLabel.bottomAnchor, constant: 16),
            paymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            paymentButton.heightAnchor.constraint(equalToConstant: 60),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func createNavigationBar() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 56, width: view.frame.width, height: 42))
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.shadowColor = .clear
        navigationBar.standardAppearance = navBarAppearance
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "backward"),
            style: .plain,
            target: self,
            action: #selector(self.backButtonTapped)
        )
        backButton.tintColor = .textPrimary
        
        let navItem = UINavigationItem(title: L10n.Currency.navItemTitle)
        navItem.leftBarButtonItem = backButton
        
        navigationBar.setItems([navItem], animated: false)
        view.addSubview(navigationBar)
    }
    
    private func bindViewModel() {
        currencyViewModel.currenciesBinding = { [weak self] _ in
            guard let self = self else { return }
            self.currencyCollectionView.reloadData()
        }
        currencyViewModel.isLoadingBinding = { [weak self] isLoading in
            guard let self = self else { return }
            if !isLoading {
                self.hideLoading()
            } else {
                self.showLoading()
            }
        }
        currencyViewModel.showPaymentResult = { [weak self] result in
            guard let self = self else { return }
            if result {
                self.showSuccessResult()
            } else {
                self.showFailResult()
            }
        }
    }
    
    private func showSuccessResult() {
        let successPayViewController = SuccessPayViewController()
        successPayViewController.modalPresentationStyle = .fullScreen
        present(successPayViewController, animated: true)
    }
    
    private func showFailResult() {
        let errorModel = ErrorModel(
            message: L10n.Currency.errorMessage,
            actionText: L10n.Currency.actionText) { [weak self] in
                guard let self = self,
                      let selectedCurrencyIndex = self.selectedCurrencyIndex else { return }
                self.currencyViewModel.paymentButtonTapped(with: selectedCurrencyIndex)
            }
        showRetryError(errorModel)
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapTermsLabel() {
        let userTermsViewController = UserTermsViewController()
        let navigationController = UINavigationController(rootViewController: userTermsViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func paymentButtonTapped() {
        guard let selectedCurrencyIndex = selectedCurrencyIndex else { return }
        currencyViewModel.paymentButtonTapped(with: selectedCurrencyIndex)
    }
}

// MARK: - Extension

extension CurrencyViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return currencyViewModel.currencies.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: CurrencyCell = currencyCollectionView.dequeueReusableCell(indexPath: indexPath)
        let currency = currencyViewModel.currencies[indexPath.row]
        cell.configure(currency: currency)
        return cell
    }
}

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: (collectionView.bounds.width - collectionParams.cellSpacing) / CGFloat(collectionParams.cellCount),
            height: collectionParams.height
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return collectionParams.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderWidth = 1
        cell?.contentView.layer.borderColor = UIColor.textPrimary.cgColor
        
        selectedCurrencyIndex = indexPath.row
        paymentButton.isEnabled = selectedCurrencyIndex != nil
        paymentButton.backgroundColor = paymentButton.isEnabled ? .segmentActive : .darkGray
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.layer.borderWidth = 0
    }
}
