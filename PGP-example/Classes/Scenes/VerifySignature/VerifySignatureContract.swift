//
//  VerifySignatureContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterVerifySignatureProtocol: KeySelectionDelegate {
    func requestVerifySignature(_ signedMessage: String)
}

// MARK: Presenter -> View

protocol PresenterToViewVerifySignatureProtocol: BaseViewProtocol {
    func showSignerPublicKey(fingerprint: String, typeString: String)
    func showVerifySignatureSuccessMessage(_ message: String)
}
