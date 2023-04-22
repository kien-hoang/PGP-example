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
        
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewVerifySignatureProtocol?
    private let pgpService: PGPService
    
    private var signerPublicKey: Keychain?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewVerifySignatureProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension VerifySignaturePresenter: ViewToPresenterVerifySignatureProtocol {
    func requestVerifySignature(_ signedMessage: String) {
        guard let signerPublicKey = signerPublicKey else {
            view?.showError("Need signer's public key!")
            return
        }
        
        do {
            try pgpService.verifySignature(signedMessage, key: signerPublicKey)
            view?.showVerifySignatureSuccessMessage("Verify signature success!")
        } catch {
            view?.showError("Verify signature failed!")
        }
    }
}

// MARK: - KeySelectionDelegate

extension VerifySignaturePresenter {
    func keySectionDidSelectKeychain(_ keychain: Keychain, type: KeychainType) {
        let fingerprint = "Fingerprint: \(keychain.getShortFingerprint() ?? "not found")"
        let typeString = "Type: \(keychain.getKeyType())"
        
        signerPublicKey = keychain
        view?.showSignerPublicKey(fingerprint: fingerprint, typeString: typeString)
    }
}
