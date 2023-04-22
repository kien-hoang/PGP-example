//
//  DecryptPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class DecryptPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewDecryptProtocol?
    private let pgpService: PGPService
    
    private var selectedKey: Key?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewDecryptProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension DecryptPresenter: ViewToPresenterDecryptProtocol {
    func requestDecryptTheMessage(_ encryptedMessage: String, passphrase: String) {
        guard let selectedKey = selectedKey else {
            view?.showError("Need select key first")
            return
        }
        
        do {
            let decryptedMessage = try pgpService.decrypt(encryptedMessage: encryptedMessage,
                                                          andVerifySignature: true,
                                                          key: selectedKey,
                                                          passphrase: passphrase)
            view?.showDecryptedMessage(decryptedMessage)
            
        } catch {
            view?.showError(error.localizedDescription)
        }
        
    }
}

// MARK: - Private

private extension DecryptPresenter {
    
}
