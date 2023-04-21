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
}

// MARK: Presenter -> View

protocol PresenterToViewListKeysProtocol: AnyObject {
    func reloadTableViewData()
}
