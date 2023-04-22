//
//  KeyGenerationPresenter.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class KeyGenerationPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewKeyGenerationProtocol?
    private let pgpService: PGPService
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewKeyGenerationProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension KeyGenerationPresenter: ViewToPresenterKeyGenerationProtocol {
    func requestGeneratePairKeys(email: String, passphrase: String) {
        view?.showLoading()
        DispatchQueue.global().async {
            let key = self.pgpService.generateNewPairKeys(email: email, passphrase: passphrase)
            
            let publicKey = key.getArmoredKey(as: .public)
            let secretKey = key.getArmoredKey(as: .secret)
            
            DispatchQueue.main.async {
                self.view?.finishLoading()
                self.view?.showPairKeys(publicKey: publicKey, privateKey: secretKey)
            }
        }
    }
}

// MARK: - Private

private extension KeyGenerationPresenter {
    
}
