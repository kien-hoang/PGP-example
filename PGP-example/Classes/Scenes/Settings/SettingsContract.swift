//
//  SettingsContract.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation

// MARK: View -> Presenter

protocol ViewToPresenterSettingsProtocol {
    func requestExportKeychain()
}

// MARK: Presenter -> View

protocol PresenterToViewSettingsProtocol: BaseViewProtocol {
    func showExportActivitySuccessPopup(with fileUrl: URL)
}
