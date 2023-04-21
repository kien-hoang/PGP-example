//
//  EncryptPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class EncryptPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewEncryptProtocol?
    private let pgpService: PGPService
    
    private var selectedKey: Key?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewEncryptProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension EncryptPresenter: ViewToPresenterEncryptProtocol {
    
    func encryptListKeysDidSelectKey(_ key: Keychain) {
        selectedKey = key
        view?.showSelectedKeyInformation(id: key.keyID.shortIdentifier,
                                         fingerprint: key.getFingerprint() ?? "---")
    }
    
    func requestEncryptMessage(_ message: String, passphrase: String) {
        guard let selectedKey = selectedKey else {
            view?.showError("Need select key first")
            return
        }
        do {
            let encryptedString = try pgpService.encrypt(message: message, key: selectedKey, passphrase: passphrase)
            view?.showEncryptedMessage(encryptedString)
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func requestEncryptMessage(_ message: String) {
        let data = "Hello Bradley 054".data(using: .utf8)!
        do {
            let encrypted = try ObjectivePGP.encrypt(data, addSignature: true, using: [PGPGlobal.shared.key])
            let encryptedMessage = Armor.armored(encrypted, as: .message)
            print("encryptedMessage: \n\(encryptedMessage)")
            
            
            guard let range = encryptedMessage.range(of: #"-----BEGIN PGP MESSAGE-----(.|\s)*-----END PGP MESSAGE-----"#,
                                            options: .regularExpression) else {
                return
            }
            let message = String(encryptedMessage[range])
            guard let messageData = message.data(using: .ascii) else { return  }
            
            
            let decrypted = try ObjectivePGP.decrypt(messageData, andVerifySignature: false, using: [PGPGlobal.shared.key], passphraseForKey: { _ in return "bradley1"
            })
            let decryptedMessage = String(data: decrypted, encoding: .utf8)
            print("decryptedMessage: \n\(decryptedMessage)")
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
}

// MARK: - Private

private extension EncryptPresenter {
    
}
