import Foundation
import UIKit

final class CartViewController: UIViewController {
    
    let servicesAssembly: ServicesAssembly
    
    private var viewModel: CartViewModel
    private var order: Order {
        return viewModel.order!
    }
    private var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartViewControllerCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private lazy var totalContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .yaLightGrayLight
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMinYCorner]
        return view
    }()
    
    private lazy var nftCountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.textColor = .textPrimary
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "3 NFT"
        return label
    }()
    
    private lazy var orderAmountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yaLightGrayLight
        label.textColor = .yaGreenUniversal
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.text = "5,34 ETH"
        return label
    }()
    
    private lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yaBlackLight
        button.setTitle("К оплате", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.primary, for: .normal)
        button.layer.cornerRadius = 16
        button.layer.masksToBounds = true
        return button
    }()
    

    init(servicesAssembly: ServicesAssembly, viewModel: CartViewModel) {
        self.servicesAssembly = servicesAssembly
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.orderBinding = { [weak self] _ in
            guard let self = self else { return }
            self.calculateTotal()
            self.orderTableView.reloadData()
        }
        view.backgroundColor = .systemBackground
        calculateTotal()
        addElements()
        setConstraints()
        createNavigationBar()
        orderTableView.dataSource = self
        orderTableView.delegate = self
    }
    
    private func calculateTotal() {
        let count = order.nfts.count
        let sum = order.nfts.reduce(0) { (result, nft) in
            result + nft.price
        }
        nftCountLabel.text = "\(count) NFT"
        orderAmountLabel.text = "\(sum) ETH"
    }
    
    private func addElements() {
        [orderTableView, totalContainerView].forEach {
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
            orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            totalContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -83),
            totalContainerView.heightAnchor.constraint(equalToConstant: 76),
            totalContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            totalContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            nftCountLabel.topAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: 16),
            nftCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            nftCountLabel.heightAnchor.constraint(equalToConstant: 22),
            nftCountLabel.widthAnchor.constraint(equalToConstant: 79),
            
            orderAmountLabel.bottomAnchor.constraint(equalTo: totalContainerView.bottomAnchor, constant: -16),
            orderAmountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            orderAmountLabel.heightAnchor.constraint(equalToConstant: 20),
            orderAmountLabel.widthAnchor.constraint(equalToConstant: 95),
            
            paymentButton.topAnchor.constraint(equalTo: totalContainerView.topAnchor, constant: 16),
            paymentButton.bottomAnchor.constraint(equalTo: totalContainerView.bottomAnchor, constant: -16),
            paymentButton.leadingAnchor.constraint(equalTo: orderAmountLabel.trailingAnchor,constant: 24),
            paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func createNavigationBar() {
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 46, width: view.frame.width - 10, height: 42))
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .primary
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
    
    @objc private func sortedButtonTapped() {
        print("Нажата кнопка сортировки")
    }
}

extension CartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.nfts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = orderTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CartViewControllerCell else {
            return UITableViewCell()
        }
        let nft = order.nfts[indexPath.row]
        cell.configure(nft: nft)
        return cell
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

