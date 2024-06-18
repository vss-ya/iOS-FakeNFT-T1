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
        tag: 0
    )
    
    private let cartTabBarItem = UITabBarItem(
        title: L10n.Tab.cart,
        image: UIImage(systemName: "basket.fill"),
        tag: 0
    )
    
    private let statisticsTabBarItem = UITabBarItem(
        title: L10n.Tab.statistics,
        image: UIImage(systemName: "flag.2.crossed.fill"),
        tag: 0
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

        let profileController = TestCatalogViewController(servicesAssembly: servicesAssembly)
        let catalogController = TestCatalogViewController(servicesAssembly: servicesAssembly)
        let cartController = CartViewController(servicesAssembly: servicesAssembly)
        let statisticsController = TestCatalogViewController(servicesAssembly: servicesAssembly)
        profileController.tabBarItem = profileTabBarItem
        catalogController.tabBarItem = catalogTabBarItem
        cartController.tabBarItem = cartTabBarItem
        
        statisticsController.tabBarItem = statisticsTabBarItem

        viewControllers = [cartController, profileController, catalogController, statisticsController]

        view.backgroundColor = .systemBackground
    }
}
