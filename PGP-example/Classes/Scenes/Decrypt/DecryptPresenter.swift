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
    
    private var receiverPrivateKey: Keychain?
    private var signerPublicKey: Keychain?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewDecryptProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension DecryptPresenter: ViewToPresenterDecryptProtocol {
    func requestDecryptTheMessage(_ encryptedMessage: String, passphrase: String) {
        guard let receiverPrivateKey = receiverPrivateKey else {
            view?.showError("Need receiver's private key!")
            return
        }
        guard !passphrase.isEmpty else {
            view?.showError("Need passphrase for receiver's private key!")
            return
        }
        
        do {
            let decryptedMessage = try pgpService.decrypt(encryptedMessage: encryptedMessage,
                                                          receiverPrivateKey: receiverPrivateKey,
                                                          signerPublicKey: signerPublicKey,
                                                          passphrase: passphrase)
            view?.showDecryptedMessage(decryptedMessage)
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func requestResetSignerPublicKey() {
        signerPublicKey = nil
    }
}

// MARK: - KeySelectionDelegate

extension DecryptPresenter {
    func keySectionDidSelectKeychain(_ keychain: Keychain, type: KeychainType) {
        let fingerprint = "Fingerprint: \(keychain.getShortFingerprint() ?? "not found")"
        let typeString = "Type: \(keychain.getKeyType())"
        
        switch type {
        case .privateKey:
            receiverPrivateKey = keychain
            view?.showReceiverPrivateKey(fingerprint: fingerprint, typeString: typeString)
            
        case .publicKey:
            signerPublicKey = keychain
            view?.showSignerPublicKey(fingerprint: fingerprint, typeString: typeString)
            
        case .both:
            fatalError("Must not this case")
        }
    }
}
