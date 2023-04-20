//
//  VerifySignaturePresenter.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import Foundation
import ObjectivePGP

final class VerifySignaturePresenter {
    
    // MARK: - Public Variable
    
    // MARK: - Private Variable
    
    private weak var view: PresenterToViewVerifySignatureProtocol?
    
    // MARK: - Lifecycle
    
    init(view: PresenterToViewVerifySignatureProtocol) {
        self.view = view
    }
}

// MARK: - ViewToPresenter

extension VerifySignaturePresenter: ViewToPresenterVerifySignatureProtocol {
    func requestVerifySignature(_ signedMessage: String) {
        guard let signedMessageData = try? Armor.readArmored(signedMessage) else { return }
        // FIXME: Testing purpose
        try? ObjectivePGP.verify(signedMessageData, withSignature: nil, using: [PGPGlobal.shared.key])
        let data = try? ObjectivePGP.decrypt(signedMessageData, andVerifySignature: false, using: [PGPGlobal.shared.key])
        let message = Armor.armored(data ?? Data(), as: .message)
    }
}

// MARK: - Private

private extension VerifySignaturePresenter {
    
}
