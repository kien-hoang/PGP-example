//
//  SigningBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class SigningBuilder {
    
    private init() {}
    
    static func build() -> SigningViewController {
        let viewController = SigningViewController.initViewController()
        let presenter = SigningPresenter(view: viewController,
                                         pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
