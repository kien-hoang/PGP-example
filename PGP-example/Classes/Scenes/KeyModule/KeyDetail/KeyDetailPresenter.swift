//
//  KeyDetailPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class KeyDetailPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewKeyDetailProtocol?
    private let key: Keychain
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewKeyDetailProtocol, key: Keychain) {
        self.view = view
        self.key = key
    }
}

// MARK: - ViewToPresenter

extension KeyDetailPresenter: ViewToPresenterKeyDetailProtocol {
    func requestShowKeyInformation() {
        let id = key.keyID.shortIdentifier
        let type = key.getKeyType()
        let expirationDate = key.getExpirationDate()
        let fingerprint = key.getFingerprint() ?? "---"
        let armoredPublicKey = key.getArmoredKey(as: .public) ?? "---"
        let armoredPrivateKey = key.getArmoredKey(as: .secret) ?? "---"
        
        let viewModel = KeyDetailViewModel(id: id,
                                           type: type,
                                           expirationDate: expirationDate,
                                           fingerprint: fingerprint,
                                           armoredPublicKey: armoredPublicKey,
                                           armoredPrivateKey: armoredPrivateKey)
        view?.showKeyInformation(viewModel: viewModel)
    }
}

// MARK: - Private

private extension KeyDetailPresenter {}

private extension Key {
    func getExpirationDate() -> String {
        guard let expirationDate = self.expirationDate else { return "Never" }
        return ISO8601DateFormatter().string(from: expirationDate)
    }
    
    func getKeyType() -> String {
        var type = "None"
        if self.isPublic && self.isSecret {
            type = "Public & Private"
        } else if self.isPublic {
            type = "Public"
        } else if self.isSecret {
            type = "Private"
        }
        return type
    }
    
    func getFingerprint() -> String? {
        if let pubKey = self.publicKey {
            return pubKey.fingerprint.description()
        } else if let privateKey = self.secretKey {
            return privateKey.fingerprint.description()
        } else {
            return nil
        }
    }
}
