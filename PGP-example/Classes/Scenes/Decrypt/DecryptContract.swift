//
//  DecryptContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterDecryptProtocol {
    func requestDecryptTheMessage(_ encryptedMessage: String, passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewDecryptProtocol: BaseViewProtocol {
    func showSelectedKeyInformation(id: String, fingerprint: String)
    func showDecryptedMessage(_ decryptedMessage: String)
}
