//
//  ListKeysPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class ListKeysPresenter {
    
    // MARK: - Public Variable
    
    var keys: [Keychain] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewListKeysProtocol?
    private let pgpService: PGPService
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewListKeysProtocol, pgpService: PGPService) {
        self.view = view
        self.pgpService = pgpService
    }
}

// MARK: - ViewToPresenter

extension ListKeysPresenter: ViewToPresenterListKeysProtocol {
    func requestAddKey(_ rawText: String) {
        do {
            let importedKeys = try pgpService.importKey(rawText)
            let isImportSuccess = !importedKeys.isEmpty
            
            if isImportSuccess {
                requestNewListKeys()
                view?.showImportKeySuccessMessage("Import success!")
            } else {
                view?.showImportKeySuccessMessage("Import failed!")
            }
            
        } catch {
            view?.showError(error.localizedDescription)
        }
    }
    
    func requestNewListKeys() {
        keys = pgpService.exportKeys(of: .both)
        view?.reloadTableViewData()
    }
}

// MARK: - Private

private extension ListKeysPresenter {
    
}
