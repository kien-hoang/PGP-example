//
//  EncryptPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation

final class EncryptPresenter {
        
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewEncryptProtocol?
    private let pgpService: PGPService
    
    private var receiverPublicKey: Keychain?
    private var signerPrivateKey: Keychain?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewEncryptProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension EncryptPresenter: ViewToPresenterEncryptProtocol {
    func requestEncryptMessage(_ message: String, passphrase: String) {
        guard let receiverPublicKey = receiverPublicKey else {
            view?.showError("Need receiver's public key!")
            return
        }
        
        if signerPrivateKey != nil, receiverPublicKey.isSecret == true {
            view?.showError("ObjectivePGP don't support if receiver key includes private keys")
            return
        }
        
        do {
            let encryptedString = try pgpService.encrypt(message: message,
                                                         receiverPublicKey: receiverPublicKey,
                                                         signerPrivateKey: signerPrivateKey,
                                                         passphrase: passphrase)
            view?.showEncryptedMessage(encryptedString)
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func requestResetSignerPrivateKey() {
        signerPrivateKey = nil
    }
}

// MARK: - KeySelectionDelegate

extension EncryptPresenter {
    func keySectionDidSelectKeychain(_ keychain: Keychain, type: KeychainType) {
        let fingerprint = "Fingerprint: \(keychain.getShortFingerprint() ?? "not found")"
        let typeString = "Type: \(keychain.getKeyType())"
        
        switch type {
        case .publicKey:
            receiverPublicKey = keychain
            view?.showReceiverPublicKey(fingerprint: fingerprint, typeString: typeString)
            
        case .privateKey:
            signerPrivateKey = keychain
            view?.showSignerPrivateKey(fingerprint: fingerprint, typeString: typeString)
            
        case .both:
            fatalError("Must not this case")
        }
    }
}
