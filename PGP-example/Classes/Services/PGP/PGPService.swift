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
}

// MARK: - Private

private extension PGPService {
    func saveKey(_ key: Key) {
        let keyring = ObjectivePGP.defaultKeyring
        keyring.import(keys: [key])
    }
}
