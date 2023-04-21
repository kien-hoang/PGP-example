//
//  SelectionKeyBuilder.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class SelectionKeyBuilder {
    
    private init() {}
    
    static func build(delegate: SelectionKeyPresenterDelegate) -> SelectionKeyViewController {
        let viewController = SelectionKeyViewController.initViewController()
        let presenter = SelectionKeyPresenter(view: viewController,
                                              pgpService: PGPService(),
                                              delegate: delegate)
        
        viewController.presenter = presenter
        
        return viewController
    }
}
