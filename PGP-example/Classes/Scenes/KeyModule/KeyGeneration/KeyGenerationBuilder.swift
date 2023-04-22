//
//  KeyGenerationBuilder.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class KeyGenerationBuilder {
    
    private init() {}
    
    static func build() -> KeyGenerationViewController {
        let viewController = KeyGenerationViewController.initViewController()
        let presenter = KeyGenerationPresenter(view: viewController,
                                              pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
