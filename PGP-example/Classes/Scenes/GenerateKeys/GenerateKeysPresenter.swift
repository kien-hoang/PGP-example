//
//  GenerateKeysPresenter.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class GenerateKeysPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewGenerateKeysProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewGenerateKeysProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension GenerateKeysPresenter: ViewToPresenterGenerateKeysProtocol {
    
}

// MARK: - Private

private extension GenerateKeysPresenter {
    
}
