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
}

// MARK: - Private

private extension PGPService {
    func saveKey(_ key: Key) {
        let keyring = ObjectivePGP.defaultKeyring
        keyring.import(keys: [key])
    }
}
