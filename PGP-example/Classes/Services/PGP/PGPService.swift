//
//  PGPService.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import Foundation
import ObjectivePGP

typealias Keychain = Key

protocol IPGPService {
    
    func getAllKeys() -> [Keychain]

    func generateNewPairKeys(email: String, passphrase: String) -> Keychain

    func encrypt(message: String, key: Keychain, passphrase: String) throws -> String

    func decrypt(encryptedMessage: String, andVerifySignature: Bool, key: Keychain, passphrase: String) throws -> String

    func sign(message: String, key: Keychain, passphrase: String) throws -> String

    func exportKeychain(with fileUrl: URL) throws
    
}

final class PGPService: IPGPService {
    
    func getAllKeys() -> [Keychain] {
        return ObjectivePGP.defaultKeyring.keys
    }
    
    func generateNewPairKeys(email: String, passphrase: String) -> Keychain {
        let key = KeyGenerator().generate(for: email, passphrase: passphrase)
        saveKey(key)
        return key
    }
    
    func encrypt(message: String, key: Keychain, passphrase: String) throws -> String {
        guard let messageData = message.data(using: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid raw input message", code: -1))
        }
        
        let encryptedData = try ObjectivePGP.encrypt(messageData,
                                                     addSignature: !passphrase.isEmpty,
                                                     using: [key],
                                                     passphraseForKey: { _ in return passphrase })
        let encryptedString = Armor.armored(encryptedData, as: .message)
        return encryptedString
    }
    
    func decrypt(encryptedMessage: String, andVerifySignature: Bool, key: Keychain, passphrase: String) throws -> String {
        guard let range = encryptedMessage.range(of: #"-----BEGIN PGP MESSAGE-----(.|\s)*-----END PGP MESSAGE-----"#,
                                        options: .regularExpression) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        let message = String(encryptedMessage[range])
        guard let messageData = message.data(using: .ascii) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        let decrypted = try ObjectivePGP.decrypt(messageData,
                                                 andVerifySignature: andVerifySignature,
                                                 using: [key],
                                                 passphraseForKey: { _ in return passphrase })
        
        guard let decryptedMessage = String(data: decrypted, encoding: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        return decryptedMessage
    }
    
    func sign(message: String, key: Keychain, passphrase: String) throws -> String {
        guard let messageData = message.data(using: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid raw input message", code: -1))
        }
        
        let signedData = try ObjectivePGP.sign(messageData,
                                               detached: false,
                                               using: [key],
                                               passphraseForKey: { _ in return passphrase })
        let signedString = Armor.armored(signedData, as: .message)
        return signedString
    }
    
    func exportKeychain(with fileUrl: URL) throws {
        let keyring = ObjectivePGP.defaultKeyring
        try keyring.export().write(to: fileUrl, options: .completeFileProtection)
    }
    
}

// MARK: - Private

private extension PGPService {
    func saveKey(_ key: Keychain) {
        let keyring = ObjectivePGP.defaultKeyring
        keyring.import(keys: [key])
    }
}
