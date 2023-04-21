//
//  EncryptContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterEncryptProtocol {
    func requestEncryptMessage(_ message: String,
                               publicKeyString: String,
                               privateKeyString: String,
                               passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewEncryptProtocol: BaseViewProtocol {
    func showEncryptedMessage(_ encryptedMessage: String)
}
