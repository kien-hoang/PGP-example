//
//  IPGPService.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//

import Foundation

protocol IPGPService {
    func exportKeys(of type: KeychainType) -> [Keychain]
    
    func generateNewPairKeys(email: String, passphrase: String) -> Keychain
    
    func encrypt(message: String, receiverPublicKey: Keychain, signerPrivateKey: Keychain?, passphrase: String) throws -> String
    
    func decrypt(encryptedMessage: String, receiverPrivateKey: Keychain, signerPublicKey: Keychain?, passphrase: String) throws -> String
    
    func sign(message: String, detached: Bool, key: Keychain, passphrase: String) throws -> String
    
    func verify(_ signedMessage: String, key: Keychain) throws
    
    func decryptSignedMessage(_ signedMessage: String, key: Keychain) throws -> String
    
    func verifySignature(_ signature: String, key: Keychain) throws
    
    func exportKeychain(with fileUrl: URL) throws
    
    func importKey(_ keyString: String) throws -> [Keychain]
    
    @discardableResult
    func importKey(_ fileUrl: URL) throws -> [Keychain]
    
    @discardableResult
    func importKeys(fileUrls: [URL]) throws -> [Keychain]
}
