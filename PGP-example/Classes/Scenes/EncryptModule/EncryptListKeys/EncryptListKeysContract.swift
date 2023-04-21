//
//  EncryptListKeysContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterEncryptListKeysProtocol {
    var keys: [Keychain] { get }
    
    func requestNewListKeys()
    func requestSelectedKey(_ key: Keychain)
}

// MARK: Presenter -> View

protocol PresenterToViewEncryptListKeysProtocol: AnyObject {
    func reloadTableViewData()
}

// MARK: - External Delegate

protocol EncryptListKeysPresenterDelegate: AnyObject {
    func encryptListKeysDidSelectKey(_ key: Keychain)
}
