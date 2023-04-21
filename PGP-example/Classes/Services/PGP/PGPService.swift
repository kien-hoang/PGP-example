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
    
}

final class PGPService: IPGPService {
    func getAllKeys() -> [Key] {
        return ObjectivePGP.defaultKeyring.keys
    }
    
    func generateNewPairKeys(email: String, passphrase: String) -> Key {
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
    
    func decrypt(encryptedMessage: String, key: Keychain, passphrase: String) throws -> String {
        guard let range = encryptedMessage.range(of: #"-----BEGIN PGP MESSAGE-----(.|\s)*-----END PGP MESSAGE-----"#,
                                        options: .regularExpression) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        let message = String(encryptedMessage[range])
        guard let messageData = message.data(using: .ascii) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        let decrypted = try ObjectivePGP.decrypt(messageData,
                                                 andVerifySignature: false,
                                                 using: [key],
                                                 passphraseForKey: { _ in return passphrase })
        
        guard let decryptedMessage = String(data: decrypted, encoding: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        return decryptedMessage
    }
}

// MARK: - Private

private extension PGPService {
    func saveKey(_ key: Key) {
        let keyring = ObjectivePGP.defaultKeyring
        keyring.import(keys: [key])
    }
}
