//
//  GenerateKeysPresenter.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class GenerateKeysPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewGenerateKeysProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewGenerateKeysProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension GenerateKeysPresenter: ViewToPresenterGenerateKeysProtocol {
    func requestGeneratePairKeys(email: String, passphrase: String) {
        view?.showLoading()
        DispatchQueue.global().async {
            let key = KeyGenerator().generate(for: email, passphrase: passphrase)
            PGPGlobal.shared.key = key // FIXME: testing purpose
            let publicKey = self.getArmoredKey(key, as: .public)
            let secretKey = self.getArmoredKey(key, as: .secret)
            
            DispatchQueue.main.async {
                self.view?.finishLoading()
                self.view?.showPairKeys(publicKey: publicKey, privateKey: secretKey)
            }
        }
    }
}

// MARK: - Private

private extension GenerateKeysPresenter {
    func getArmoredKey(_ key: Key, as type: PGPKeyType) -> String? {
        guard let keyData = try? key.export(keyType: type) else { return nil }

        switch type {
        case .public:
            return Armor.armored(keyData, as: .publicKey)
        case .secret:
            return Armor.armored(keyData, as: .secretKey)
        default:
            return nil
        }
    }
}
