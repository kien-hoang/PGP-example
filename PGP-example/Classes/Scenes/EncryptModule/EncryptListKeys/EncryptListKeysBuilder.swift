//
//  EncryptListKeysBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class EncryptListKeysBuilder {
    
    private init() {}
    
    static func build(delegate: EncryptListKeysPresenterDelegate) -> EncryptListKeysViewController {
        let viewController = EncryptListKeysViewController.initViewController()
        let presenter = EncryptListKeysPresenter(view: viewController,
                                                 pgpService: PGPService(),
                                                 delegate: delegate)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
