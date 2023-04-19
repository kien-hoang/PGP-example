//
//  AppRouter.swift
//  Food Tracker iOS
//
//  Created by bradley.hoang99@gmail.com on 04/04/2023.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Public

extension AppRouter {
    func showRootView() {
        let tabBar = TabBarBuilder.build()
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}
