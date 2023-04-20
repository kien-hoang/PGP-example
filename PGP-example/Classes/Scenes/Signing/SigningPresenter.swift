//
//  SigningPresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

class PGPGlobal {
    static let shared = PGPGlobal()
    
    var key: Key!
}

final class SigningPresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewSigningProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewSigningProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension SigningPresenter: ViewToPresenterSigningProtocol {
    func requestSigningMessage(_ message: String, passPhrase: String) {
        view?.showLoading()
        DispatchQueue.global().async {
            // FIXME: Testing purpose
            guard let data = message.data(using: .utf8) else { return }
            let signedMessageData = try? ObjectivePGP.sign(data, detached: false, using: [PGPGlobal.shared.key]) { _ in passPhrase }
            let signedMessage = Armor.armored(signedMessageData ?? Data(), as: .message)
            
            DispatchQueue.main.async {
                self.view?.finishLoading()
                self.view?.showSignedMessage(signedMessage)
            }
        }
    }
}

// MARK: - Private

private extension SigningPresenter {
    
}
