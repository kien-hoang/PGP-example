//
//  EncryptContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterEncryptProtocol: SelectionKeyPresenterDelegate {
    func requestEncryptMessage(_ message: String, passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewEncryptProtocol: BaseViewProtocol {
    func showSelectedKeyInformation(id: String, fingerprint: String)
    func showEncryptedMessage(_ encryptedMessage: String)
}
