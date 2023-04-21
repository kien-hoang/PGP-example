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
    func requestNewListKeys() {
        keys = pgpService.getAllKeys()
        view?.reloadTableViewData()
    }
}

// MARK: - Private

private extension ListKeysPresenter {
    
}
