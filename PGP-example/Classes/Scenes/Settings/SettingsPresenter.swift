//
//  SettingsPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation
import ObjectivePGP
import UIKit // testing

final class SettingsPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSettingsProtocol?
    private let pgpService: PGPService
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSettingsProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension SettingsPresenter: ViewToPresenterSettingsProtocol {
    func requestExportKeychain() {
        let file = "pgp-example-keychain.gpg"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileUrl = dir.appendingPathComponent(file)
            do {
                try pgpService.exportKeychain(with: fileUrl)
                view?.showExportActivitySuccessPopup(with: fileUrl)
            } catch {
                view?.showError("Export failed!")
                return
            }
        } else {
            view?.showError("Export failed!")
        }
    }
}

// MARK: - Private

private extension SettingsPresenter {
    
}
