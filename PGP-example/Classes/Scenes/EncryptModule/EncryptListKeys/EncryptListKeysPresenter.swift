//
//  EncryptListKeysPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

final class EncryptListKeysPresenter {
    
    // MARK: - Public Variable
    
    var keys: [Keychain] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewEncryptListKeysProtocol?
    private let pgpService: PGPService
    private weak var delegate: EncryptListKeysPresenterDelegate?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewEncryptListKeysProtocol,
         pgpService: PGPService,
         delegate: EncryptListKeysPresenterDelegate) {
        self.view = view
        self.pgpService = pgpService
        self.delegate = delegate
    }
}

// MARK: - ViewToPresenter

extension EncryptListKeysPresenter: ViewToPresenterEncryptListKeysProtocol {
    func requestNewListKeys() {
        keys = pgpService.getAllKeys()
        view?.reloadTableViewData()
    }
    
    func requestSelectedKey(_ key: Keychain) {
        delegate?.encryptListKeysDidSelectKey(key)
    }
}

// MARK: - Private

private extension EncryptListKeysPresenter {
    
}
