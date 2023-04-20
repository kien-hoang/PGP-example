//
//  SigningContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterSigningProtocol {
    func requestSigningMessage(_ message: String, passPhrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewSigningProtocol: BaseViewProtocol {
    func showSignedMessage(_ signedMessage: String)
}
