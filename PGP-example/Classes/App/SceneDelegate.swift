//
//  SceneDelegate.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Private Variable
    
    private var appRouter: AppRouter?
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        (UIApplication.shared.delegate as? AppDelegate)?.window = window
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let appRouter = AppRouter(window: window!)
        appRouter.showRootView()
    }

}

