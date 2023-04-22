//
//  PGPService.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import Foundation
import ObjectivePGP

typealias Keychain = Key

enum KeychainType {
    case publicKey
    case privateKey
    case both
}

protocol IPGPService {} // update later

final class PGPService: IPGPService {
    
    func exportKeys(of type: KeychainType) -> [Keychain] {
        switch type {
        case .publicKey:
            return ObjectivePGP.defaultKeyring.keys.filter { $0.isPublic }
        case .privateKey:
            return ObjectivePGP.defaultKeyring.keys.filter { $0.isSecret }
        case .both:
            return ObjectivePGP.defaultKeyring.keys
        }
    }
    
    func generateNewPairKeys(email: String, passphrase: String) -> Keychain {
        let key = KeyGenerator().generate(for: email, passphrase: passphrase)
        saveKeys([key])
        return key
    }
    
    func encrypt(message: String,
                 receiverPublicKey: Keychain,
                 signerPrivateKey: Keychain?,
                 passphrase: String) throws -> String {
        
        var inputKeys: [Keychain] = [receiverPublicKey]
        var addSignature: Bool = false
        
        if let signerPrivateKey = signerPrivateKey {
            addSignature = true
            inputKeys.append(signerPrivateKey)
        }
        
        guard let messageData = message.data(using: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid raw input message", code: -1))
        }
        
        let encryptedData = try ObjectivePGP.encrypt(messageData,
                                                     addSignature: addSignature,
                                                     using: inputKeys,
                                                     passphraseForKey: { _ in return passphrase })
        let encryptedString = Armor.armored(encryptedData, as: .message)
        return encryptedString
    }
    
//    func encrypt(message: String, key: Keychain, passphrase: String) throws -> String {
//        guard let messageData = message.data(using: .utf8) else {
//            throw PGPError(_nsError: NSError(domain: "Invalid raw input message", code: -1))
//        }
//
//        let encryptedData = try ObjectivePGP.encrypt(messageData,
//                                                     addSignature: !passphrase.isEmpty,
//                                                     using: [key],
//                                                     passphraseForKey: { _ in return passphrase })
//        let encryptedString = Armor.armored(encryptedData, as: .message)
//        return encryptedString
//    }
    
    func decrypt(encryptedMessage: String,
                 receiverPrivateKey: Keychain,
                 signerPublicKey: Keychain?,
                 passphrase: String) throws -> String {
        
        var inputKeys: [Keychain] = [receiverPrivateKey]
        var andVerifySignature: Bool = false
        
        if let signerPublicKey = signerPublicKey {
            andVerifySignature = true
            inputKeys.append(signerPublicKey)
        }
        
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
                                                 using: inputKeys,
                                                 passphraseForKey: { _ in return passphrase })
        
        guard let decryptedMessage = String(data: decrypted, encoding: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        return decryptedMessage
    }
    
//    func decrypt(encryptedMessage: String, andVerifySignature: Bool, key: Keychain, passphrase: String) throws -> String {
//        guard let range = encryptedMessage.range(of: #"-----BEGIN PGP MESSAGE-----(.|\s)*-----END PGP MESSAGE-----"#,
//                                        options: .regularExpression) else {
//            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
//        }
//
//        let message = String(encryptedMessage[range])
//        guard let messageData = message.data(using: .ascii) else {
//            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
//        }
//
//        let decrypted = try ObjectivePGP.decrypt(messageData,
//                                                 andVerifySignature: andVerifySignature,
//                                                 using: [key],
//                                                 passphraseForKey: { _ in return passphrase })
//
//        guard let decryptedMessage = String(data: decrypted, encoding: .utf8) else {
//            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
//        }
//        return decryptedMessage
//    }
    
    func sign(message: String, detached: Bool, key: Keychain, passphrase: String) throws -> String {
        guard let messageData = message.data(using: .utf8) else {
            throw PGPError(_nsError: NSError(domain: "Invalid raw input message", code: -1))
        }
        
        let signedData = try ObjectivePGP.sign(messageData,
                                               detached: detached,
                                               using: [key],
                                               passphraseForKey: { _ in return passphrase })
        let signedString = Armor.armored(signedData, as: .message)
        return signedString
    }
    
    func verify(_ signedMessage: String, key: Keychain) throws {
        let messageData = try Armor.readArmored(signedMessage)
        try ObjectivePGP.verify(messageData, withSignature: nil, using: [key])
    }
    
    func verifySignature(_ signature: String, key: Keychain) throws {
        guard let range = signature.range(of: #"-----BEGIN PGP MESSAGE-----(.|\s)*-----END PGP MESSAGE-----"#,
                                        options: .regularExpression) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        let signature = String(signature[range])
        guard let signatureData = signature.data(using: .ascii) else {
            throw PGPError(_nsError: NSError(domain: "Invalid encrypted message", code: -1))
        }
        
        try ObjectivePGP.verifySignature(signatureData, using: [key])
    }
    
    func exportKeychain(with fileUrl: URL) throws {
        let keyring = ObjectivePGP.defaultKeyring
        try keyring.export().write(to: fileUrl, options: .completeFileProtection)
    }
    
    func importKey(_ keyString: String) throws -> [Keychain] {
        guard let asciiKeyData = keyString.data(using: .ascii) else {
            throw PGPError(_nsError: NSError(domain: "Invalid raw input text", code: -1))
        }

        var readKeys: [Keychain] = []
        readKeys = try ObjectivePGP.readKeys(from: asciiKeyData)
        for key in readKeys {
            try keyIsSupported(key: key)
        }
        
        saveKeys(readKeys)
        return readKeys
    }
    
    @discardableResult
    func importKey(_ fileUrl: URL) throws -> [Keychain] {
        var readKeys: [Keychain] = []
        readKeys = try ObjectivePGP.readKeys(fromPath: fileUrl.path)
        for key in readKeys {
            try keyIsSupported(key: key)
        }
        
        saveKeys(readKeys)
        return readKeys
    }
    
    @discardableResult
    func importKeys(fileUrls: [URL]) throws -> [Keychain] {
        var keys: [Keychain] = []
        for fileUrl in fileUrls {
            let key = try importKey(fileUrl)
            keys.append(contentsOf: key)
        }
        
        return keys
    }
}

// MARK: - Private

private extension PGPService {
    func saveKeys(_ keys: [Keychain]) {
        let keyring = ObjectivePGP.defaultKeyring
        keyring.import(keys: keys)
    }
    
    func keyIsSupported(key: Keychain) throws {
        try key.export()
    }
}
