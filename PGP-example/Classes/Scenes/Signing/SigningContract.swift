//
//  SigningContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterSigningProtocol: KeySelectionDelegate {
    func requestSigningMessage(_ message: String, passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewSigningProtocol: BaseViewProtocol {
    func showSelectedKeyInformation(fingerprint: String, typeString: String)
    func showSignedMessage(_ signedMessage: String)
}
