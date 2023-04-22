//
//  ListKeysContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterListKeysProtocol {
    var keys: [Keychain] { get }
    
    func requestNewListKeys()
    func requestAddKey(_ rawText: String)
    func requestDocumentPicker(didPickAt urls: [URL])
}

// MARK: Presenter -> View

protocol PresenterToViewListKeysProtocol: BaseViewProtocol {
    func reloadTableViewData()
    func showImportKeySuccessMessage(_ message: String)
}
