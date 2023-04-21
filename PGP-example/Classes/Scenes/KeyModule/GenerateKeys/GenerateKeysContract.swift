//
//  GenerateKeysContract.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterGenerateKeysProtocol {
    func requestGeneratePairKeys(email: String, passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewGenerateKeysProtocol: BaseViewProtocol {
    func showPairKeys(publicKey: String?, privateKey: String?)
}
