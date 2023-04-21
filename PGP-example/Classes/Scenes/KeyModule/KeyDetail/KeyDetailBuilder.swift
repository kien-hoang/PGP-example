//
//  KeyDetailBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class KeyDetailBuilder {
    
    private init() {}
    
    static func build(key: Keychain) -> KeyDetailViewController {
        let viewController = KeyDetailViewController.initViewController()
        let presenter = KeyDetailPresenter(view: viewController, key: key)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
