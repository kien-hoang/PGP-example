//
//  TabBarPresenter.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation

enum TabBarType: Int, CaseIterable {
    case generateKeys = 0
    case signing
    case verifySignature
    case encrypt
    case decrypt
    
    var title: String {
        switch self {
        case .generateKeys:
            return "Keys"
        case .signing:
            return "Signing"
        case .verifySignature:
            return "Verify"
        case .encrypt:
            return "Encrypt"
        case .decrypt:
            return "Decrypt"
        }
    }
}

final class TabBarPresenter {
    
    // MARK: - Public Variable
    
    var tabBarItems: [TabBarType] = [.generateKeys, .signing, .verifySignature]
    
    // MARK: - Private Variable
    
    weak var view: PresenterToViewTabBarProtocol?
}

// MARK: - ViewToPresenter

extension TabBarPresenter: ViewToPresenterTabBarProtocol {
    
}

// MARK: - Private

private extension TabBarPresenter {
    
}
