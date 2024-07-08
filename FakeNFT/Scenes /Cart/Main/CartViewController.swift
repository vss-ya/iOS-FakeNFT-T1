import Foundation
import UIKit

final class CartViewController: UIViewController, LoadingView {
    
    // MARK: - Properties
    
    private let servicesAssembly: ServicesAssembly
    private let refreshControl = UIRefreshControl()
    private let viewModel: CartViewModel
    private var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CartViewControllerCell.self)
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private lazy var totalContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yaLightGrayLight
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isHidden = true
        return view
    }()
    
    private lazy var nftCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.textColor = .textPrimary
        label.font = .caption1
        return label
    }()
    
    private lazy var orderAmountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.numberOfLines = 1
        label.textColor = .yaGreenUniversal
        label.font = .bodyBold
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yaBlackLight
        button.setTitle(L10n.Cart.paymentButtonTitle, for: .normal)
        button.titleLabel?.font = .bodyBold
        button.setTitleColor(.primary, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var emptyCartLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.numberOfLines = 1
        label.textColor = .textPrimary
        label.font = .bodyBold
        label.text = L10n.Cart.emptyCart
        label.isHidden = true
        return label
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .yaBlackLight
        return activityIndicator
    }()
    
    // MARK: - Initialization
    
    init(
        servicesAssembly: ServicesAssembly,
        viewModel: CartViewModel
    ) {
        self.servicesAssembly = servicesAssembly
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getOrder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        calculateTotal()
        addElements()
        setConstraints()
        bindViewModel()
        createNavigationBar()
        orderTableView.dataSource = self
        orderTableView.delegate = self
        checkIfCartIsEmpty()
        setupRefreshControl()
    }
    
    // MARK: - Private Function
    
    private func bindViewModel() {
        viewModel.orderedNftsBinding = { [weak self] _ in
            guard let self = self else { return }
            self.checkIfCartIsEmpty()
            self.calculateTotal()
            self.orderTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewModel.isLoadingBinding = { [weak self] isLoading in
            guard let self = self else { return }
            if !isLoading {
                self.checkIfCartIsEmpty()
                self.hideLoading()
            } else {
                [self.totalContainerView,
                 self.paymentButton,
                 self.navigationBar,
                 self.emptyCartLabel
                ].forEach { $0.isHidden = true }
                self.showLoading()
            }
        }
    }
    
    private func checkIfCartIsEmpty() {
        changeStateEmptyCart(isHidden: viewModel.orderedNfts.isEmpty)
    }
    
    private func changeStateEmptyCart(isHidden: Bool) {
        emptyCartLabel.isHidden = !isHidden
        [totalContainerView, paymentButton, navigationBar].forEach { $0.isHidden = isHidden }
    }
    
    private func calculateTotal() {
        let count = viewModel.orderedNfts.count
        let totalSum = viewModel.orderedNfts.reduce(0) { (result, nft) in
            result + nft.price
        }
        let sumString = String(format: "%.2f", totalSum)
        nftCountLabel.text = "\(count) NFT"
        orderAmountLabel.text = sumString + " ETH"
    }
    
    private func addElements() {
        [orderTableView, totalContainerView, emptyCartLabel, activityIndicator].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        [nftCountLabel, orderAmountLabel, paymentButton].forEach {
            totalContainerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            orderTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 108),
            orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            totalContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
            totalContainerView.heightAnchor.constraint(equalToConstant: 76),
            totalContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nftCountLabel.topAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: 16),
            nftCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nftCountLabel.heightAnchor.constraint(equalToConstant: 22),
            nftCountLabel.widthAnchor.constraint(equalToConstant: 79),
            
            orderAmountLabel.bottomAnchor.constraint(equalTo: totalContainerView.bottomAnchor, constant: -16),
            orderAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            orderAmountLabel.heightAnchor.constraint(equalToConstant: 20),
            
            paymentButton.topAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: 16),
            paymentButton.bottomAnchor.constraint(equalTo: totalContainerView.bottomAnchor, constant: -16),
            paymentButton.leadingAnchor.constraint(equalTo: orderAmountLabel.trailingAnchor, constant: 24),
            paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            emptyCartLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyCartLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyCartLabel.heightAnchor.constraint(equalToConstant: 22),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    private func createNavigationBar() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 46, width: view.frame.width, height: 42))
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .systemBackground
        navBarAppearance.shadowColor = .clear
        navigationBar.standardAppearance = navBarAppearance
        
        let navItem = UINavigationItem()
        let sortedButton = UIBarButtonItem(
            image: UIImage(named: "sort"),
            style: .plain,
            target: self,
            action: #selector(self.sortedButtonTapped)
        )
        sortedButton.tintColor = .textPrimary
        navItem.rightBarButtonItem = sortedButton
        
        navigationBar.setItems([navItem], animated: false)
        view.addSubview(navigationBar)
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshCart), for: .valueChanged)
        orderTableView.refreshControl = refreshControl
    }
    
    private func didTapDeleteButton(image: UIImage, id: String) {
        let deleteConfirmationViewController = ConfirmDeleteViewController(
            image: image,
            viewModel: viewModel, id: id
        )
        deleteConfirmationViewController.modalPresentationStyle = .overCurrentContext
        deleteConfirmationViewController.modalTransitionStyle = .crossDissolve
        present(deleteConfirmationViewController, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc private func sortedButtonTapped() {
        let sortSheet = UIAlertController(title: L10n.Cart.sortTitle, message: nil, preferredStyle: .actionSheet)
        let sortOption = viewModel.getSortPredicate()
        for option in SortOption.allCases {
            addAction(to: sortSheet, sortPredicate: option, isSelected: option == sortOption)
        }
        let closeAction = UIAlertAction(title: L10n.Cart.close, style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }
        sortSheet.addAction(closeAction)
        present(sortSheet, animated: true, completion: nil)
    }
    
    private func addAction(to alert: UIAlertController, sortPredicate: SortOption, isSelected: Bool) {
        let style: UIAlertAction.Style = isSelected ? .destructive : .default
        let action = UIAlertAction(title: sortPredicate.localizedString, style: style) { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.saveSorting(sortPredicate: sortPredicate)
            self.orderTableView.reloadData()
        }
        alert.addAction(action)
    }
    
    @objc private func refreshCart() {
        viewModel.getOrder()
    }
    
    @objc private func paymentButtonTapped() {
        let networkClient = DefaultNetworkClient()
        let currencyViewModel = CurrencyViewModel(networkClient: networkClient)
        let currencyViewController = CurrencyViewController(currencyViewModel: currencyViewModel)
        currencyViewController.modalPresentationStyle = .fullScreen
        self.present(currencyViewController, animated: true)
    }
}

// MARK: - Extension

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.orderedNfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartViewControllerCell = orderTableView.dequeueReusableCell()
        let nft = viewModel.orderedNfts[indexPath.row]
        cell.configure(nft: nft)
        cell.selectionStyle = .none
        cell.deleteButtonAction = { [weak self] image in
            guard let self = self else { return }
            self.didTapDeleteButton(image: image, id: nft.id)
        }
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
