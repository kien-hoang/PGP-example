//
//  VerifySignaturePresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class VerifySignaturePresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewVerifySignatureProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewVerifySignatureProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension VerifySignaturePresenter: ViewToPresenterVerifySignatureProtocol {
    func requestVerifySignature(_ signedMessage: String) {
        
    }
}

// MARK: - Private

private extension VerifySignaturePresenter {
    
}
