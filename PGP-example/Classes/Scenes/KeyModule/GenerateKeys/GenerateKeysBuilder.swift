//
//  GenerateKeysBuilder.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class GenerateKeysBuilder {
    
    private init() {}
    
    static func build() -> GenerateKeysViewController {
        let viewController = GenerateKeysViewController.initViewController()
        let presenter = GenerateKeysPresenter(view: viewController,
                                              pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
