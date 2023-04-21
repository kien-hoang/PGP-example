//
//  EncryptBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation

final class EncryptBuilder {
    
    private init() {}
    
    static func build() -> EncryptViewController {
        let viewController = EncryptViewController.initViewController()
        let presenter = EncryptPresenter(view: viewController,
                                         pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
