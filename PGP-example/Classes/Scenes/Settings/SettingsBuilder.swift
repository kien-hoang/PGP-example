//
//  SettingsBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation

final class SettingsBuilder {
    
    private init() {}
    
    static func build() -> SettingsViewController {
        let viewController = SettingsViewController.initViewController()
        let presenter = SettingsPresenter(view: viewController,
                                          pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
