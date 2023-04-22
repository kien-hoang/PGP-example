//
//  VerifySignatureBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class VerifySignatureBuilder {
    
    private init() {}
    
    static func build() -> VerifySignatureViewController {
        let viewController = VerifySignatureViewController.initViewController()
        let presenter = VerifySignaturePresenter(view: viewController,
                                                 pgpService: PGPService())
        
        viewController.presenter = presenter
        
        return viewController
    }
}
