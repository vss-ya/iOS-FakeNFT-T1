import Foundation
import UIKit

final class CartViewController: UIViewController {
    
    let servicesAssembly: ServicesAssembly
    
    private var order: Order = MockData().mockOrder
    
    private lazy var orderTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartViewControllerCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return tableView
        
    }()

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        addElements()
        setConstraints()
        orderTableView.dataSource = self
        orderTableView.delegate = self
    }
    
    private func addElements() {
        [orderTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            orderTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            orderTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            orderTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            orderTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
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

