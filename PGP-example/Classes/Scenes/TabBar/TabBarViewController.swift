//
//  TabBarViewController.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

final class TabBarViewController: UITabBarController {
        
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterTabBarProtocol
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    init(presenter: ViewToPresenterTabBarProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - PresenterToView

extension TabBarViewController: PresenterToViewTabBarProtocol {
    
}

// MARK: - Private

private extension TabBarViewController {
    func setupUI() {
        setupTabBarItems()
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray.withAlphaComponent(0.05)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func setupTabBarItems() {
        let viewControllers: [UIViewController] = presenter.tabBarItems.map {
            switch $0 {
            case .generateKeys:
                let viewController = ListKeysBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "key"),
                                                         tag: 0)
                return UINavigationController(rootViewController: viewController)
                
            case .signing:
                let viewController = SigningBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "signature"),
                                                         tag: 1)
                return UINavigationController(rootViewController: viewController)
                
            case .verifySignature:
                let viewController = VerifySignatureBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "square.and.pencil"),
                                                         tag: 2)
                return UINavigationController(rootViewController: viewController)
                
            case .encrypt:
                let viewController = EncryptBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "lock"),
                                                         tag: 3)
                return UINavigationController(rootViewController: viewController)
                
            case .decrypt:
                let viewController = DecryptBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "lock.open"),
                                                         tag: 3)
                return UINavigationController(rootViewController: viewController)
                
            case .settings:
                let viewController = SettingsBuilder.build()
                viewController.tabBarItem = UITabBarItem(title: $0.title,
                                                         image: UIImage(systemName: "gear"),
                                                         tag: 3)
                return UINavigationController(rootViewController: viewController)
            }
        }
        self.viewControllers = viewControllers
    }
}
