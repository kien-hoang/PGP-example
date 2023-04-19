//
//  TabBarBuilder.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class TabBarBuilder {
    
    private init() {}
    
    static func build() -> TabBarViewController {
        let presenter = TabBarPresenter()
        let viewController = TabBarViewController(presenter: presenter)
        
        presenter.view = viewController
        
        return viewController
    }
}
