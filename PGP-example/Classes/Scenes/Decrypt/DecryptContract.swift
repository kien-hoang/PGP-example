//
//  DecryptContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterDecryptProtocol: KeySelectionDelegate {
    func requestDecryptTheMessage(_ encryptedMessage: String, passphrase: String)
    func requestResetSignerPublicKey()
}

// MARK: Presenter -> View

protocol PresenterToViewDecryptProtocol: BaseViewProtocol {
    func showReceiverPrivateKey(fingerprint: String, typeString: String)
    func showSignerPublicKey(fingerprint: String, typeString: String)
    
    func showDecryptedMessage(_ decryptedMessage: String)
}
