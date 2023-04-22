//
//  SigningPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class SigningPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSigningProtocol?
    private let pgpService: PGPService
    
    private var selectedKey: Key?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSigningProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension SigningPresenter: ViewToPresenterSigningProtocol {
    func encryptListKeysDidSelectKey(_ key: Keychain) {
        selectedKey = key
        view?.showSelectedKeyInformation(id: key.keyID.shortIdentifier,
                                         fingerprint: key.getFingerprint() ?? "---")
    }
    
    func requestSigningMessage(_ message: String, passphrase: String) {
        guard let selectedKey = selectedKey else {
            view?.showError("Need select key first")
            return
        }
        
        do {
            let signedString = try pgpService.sign(message: message, key: selectedKey, passphrase: passphrase)
            view?.showSignedMessage(signedString)
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
}

// MARK: - Private

private extension SigningPresenter {
    
}
