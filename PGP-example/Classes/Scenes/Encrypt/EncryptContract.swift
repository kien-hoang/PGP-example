//
//  EncryptContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterEncryptProtocol: KeySelectionDelegate {
    func requestEncryptMessage(_ message: String, passphrase: String)
    func requestResetSignerPrivateKey()
}

// MARK: Presenter -> View

protocol PresenterToViewEncryptProtocol: BaseViewProtocol {
    func showReceiverPublicKey(fingerprint: String, typeString: String)
    func showSignerPrivateKey(fingerprint: String, typeString: String)
    
    func showEncryptedMessage(_ encryptedMessage: String)
}
