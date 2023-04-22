//
//  KeySelectionContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterKeySelectionProtocol {
    var keys: [Keychain] { get }
    
    func requestNewListKeys()
    func requestDidSelectKeychain(_ keychain: Keychain)
}

// MARK: Presenter -> View

protocol PresenterToViewKeySelectionProtocol: AnyObject {
    func updateUI(with title: String)
    func reloadTableViewData()
}
