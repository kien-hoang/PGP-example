//
//  KeySelectionBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation

final class KeySelectionBuilder {
    
    private init() {}
    
    static func build(keychainType: KeychainType,
                      delegate: KeySelectionDelegate) -> KeySelectionViewController {
        let viewController = KeySelectionViewController.initViewController()
        let presenter = KeySelectionPresenter(view: viewController,
                                              pgpService: PGPService(),
                                              keychainType: keychainType,
                                              delegate: delegate)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
