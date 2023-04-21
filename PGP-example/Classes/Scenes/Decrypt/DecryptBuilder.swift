//
//  DecryptBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class DecryptBuilder {
    
    private init() {}
    
    static func build() -> DecryptViewController {
        let viewController = DecryptViewController.initViewController()
        let presenter = DecryptPresenter(view: viewController,
                                         pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
