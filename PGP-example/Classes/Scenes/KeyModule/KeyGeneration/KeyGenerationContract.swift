//
//  KeyGenerationContract.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterKeyGenerationProtocol {
    func requestGeneratePairKeys(email: String, passphrase: String)
}

// MARK: Presenter -> View

protocol PresenterToViewKeyGenerationProtocol: BaseViewProtocol {
    func showPairKeys(publicKey: String?, privateKey: String?)
}
