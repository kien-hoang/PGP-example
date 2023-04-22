//
//  KeySelectionPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import Foundation

final class KeySelectionPresenter {
    
    // MARK: - Public Variable
    
    var keys: [Keychain] = []
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewKeySelectionProtocol?
    private let pgpService: PGPService
    private let keychainType: KeychainType
    private weak var delegate: KeySelectionDelegate?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewKeySelectionProtocol,
         pgpService: PGPService,
         keychainType: KeychainType,
         delegate: KeySelectionDelegate) {
        self.view = view
        self.pgpService = pgpService
        self.keychainType = keychainType
        self.delegate = delegate
    }
}

// MARK: - ViewToPresenter

extension KeySelectionPresenter: ViewToPresenterKeySelectionProtocol {
    func requestNewListKeys() {
        keys = pgpService.exportKeys(of: keychainType)
        view?.updateUI(with: keychainType.title)
        view?.reloadTableViewData()
    }
    
    func requestDidSelectKeychain(_ keychain: Keychain) {
        delegate?.keySectionDidSelectKeychain(keychain, type: keychainType)
    }
}

// MARK: - Private

private extension KeySelectionPresenter {
    
}

fileprivate extension KeychainType {
    var title: String {
        switch self {
        case .publicKey:
            return "Select the public key"
        case .privateKey:
            return "Select the private key"
        case .both:
            return "Select the key"
        }
    }
}
