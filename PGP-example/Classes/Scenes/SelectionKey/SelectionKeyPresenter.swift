//
//  SelectionKeyPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import Foundation

enum SelectionKeyType {
    case bothKeys
    case publicKey
    case privateKey
}

final class SelectionKeyPresenter {
    
    // MARK: - Public Variable
    
    var keys: [Keychain] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSelectionKeyProtocol?
    private let pgpService: PGPService
    private weak var delegate: SelectionKeyPresenterDelegate?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSelectionKeyProtocol,
         pgpService: PGPService,
         delegate: SelectionKeyPresenterDelegate) {
        self.view = view
        self.pgpService = pgpService
        self.delegate = delegate
    }
}

// MARK: - ViewToPresenter

extension SelectionKeyPresenter: ViewToPresenterSelectionKeyProtocol {
    func requestNewListKeys() {
        keys = pgpService.getAllKeys()
        view?.reloadTableViewData()
    }
    
    func requestSelectedKey(_ key: Keychain) {
        delegate?.encryptListKeysDidSelectKey(key)
    }
}

// MARK: - Private

private extension SelectionKeyPresenter {
    
}
