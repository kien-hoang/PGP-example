//
//  SigningPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

final class SigningPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSigningProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSigningProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension SigningPresenter: ViewToPresenterSigningProtocol {
    
}

// MARK: - Private

private extension SigningPresenter {
    
}
