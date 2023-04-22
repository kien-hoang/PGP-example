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

// MARK: - KeySelectionDelegate

extension SigningPresenter {
    func keySectionDidSelectKeychain(_ keychain: Keychain, type: KeychainType) {
        let fingerprint = "Fingerprint: \(keychain.getShortFingerprint() ?? "not found")"
        let typeString = "Type: \(keychain.getKeyType())"
        
        selectedKey = keychain
        view?.showSelectedKeyInformation(fingerprint: fingerprint, typeString: typeString)
    }
}
