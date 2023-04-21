//
//  ListKeysBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class ListKeysBuilder {
    
    private init() {}
    
    static func build() -> ListKeysViewController {
        let viewController = ListKeysViewController.initViewController()
        let presenter = ListKeysPresenter(view: viewController,
                                          pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
