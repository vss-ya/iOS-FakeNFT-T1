import UIKit

final class TabBarController: UITabBarController {

    var servicesAssembly: ServicesAssembly

    private let profileTabBarItem = UITabBarItem(
        title: L10n.Tab.profile,
        image: UIImage(systemName: "person.crop.circle.fill"),
        tag: 0
    )

    private let catalogTabBarItem = UITabBarItem(
        title: L10n.Tab.catalog,
        image: UIImage(systemName: "rectangle.stack.fill"),
        tag: 1
    )

    private let cartTabBarItem = UITabBarItem(
        title: L10n.Tab.cart,
        image: UIImage(systemName: "basket.fill"),
        tag: 2
    )

    private let statisticsTabBarItem = UITabBarItem(
        title: L10n.Tab.statistics,
        image: UIImage(systemName: "flag.2.crossed.fill"),
        tag: 3
    )

    init(servicesAssembly: ServicesAssembly) {
        self.servicesAssembly = servicesAssembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let catalogController = UINavigationController(rootViewController: CatalogViewController(viewModel: CatalogViewModel()))
        let profileController = initProfileTabBarViewController(servicesAssembly)

        let networkClient = DefaultNetworkClient()
        let storage = NftStorageImpl()
        let nftService = NftServiceImpl(networkClient: networkClient, storage: storage)
        let viewModel = CartViewModel(networkClient: networkClient, nftService: nftService)
        let cartController = CartViewController(servicesAssembly: servicesAssembly, viewModel: viewModel)

        let statisticsViewController = StatisticsViewController(viewModel: StatisticsViewModel())
        let statisticsNavigationController = UINavigationController(rootViewController: statisticsViewController)
        statisticsNavigationController.modalPresentationStyle = .overCurrentContext

        profileController.tabBarItem = profileTabBarItem
        catalogController.tabBarItem = catalogTabBarItem
        cartController.tabBarItem = cartTabBarItem
        statisticsNavigationController.tabBarItem = statisticsTabBarItem

        viewControllers = [profileController, catalogController, cartController, statisticsNavigationController]

        view.backgroundColor = .systemBackground
    }

    func returnToCatalog() {
        self.selectedIndex = 1
    }

    private func initProfileTabBarViewController(_ servicesAssembly: ServicesAssembly) -> UIViewController {
        let viewModel = ProfileViewModel(servicesAssembly)
        let vc = ProfileViewController(viewModel)
        let navVc = UINavigationController(rootViewController: vc)
        return navVc
    }
}
