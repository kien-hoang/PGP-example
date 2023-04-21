//
//  KeyDetailContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterKeyDetailProtocol {
    func requestShowKeyInformation()
}

// MARK: Presenter -> View

protocol PresenterToViewKeyDetailProtocol: AnyObject {
    func showKeyInformation(viewModel: KeyDetailViewModel)
}
