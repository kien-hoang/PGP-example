//
//  PGPKey+Extensions.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import Foundation
import ObjectivePGP

extension Key {
    func getArmoredKey(as type: PGPKeyType) -> String? {
        guard let keyData = try? self.export(keyType: type) else { return nil }
        
        switch type {
        case .public:
            return Armor.armored(keyData, as: .publicKey)
        case .secret:
            return Armor.armored(keyData, as: .secretKey)
        default:
            return nil
        }
    }
    
    func getFingerprint() -> String? {
        if let pubKey = self.publicKey {
            return pubKey.fingerprint.description()
        } else if let privateKey = self.secretKey {
            return privateKey.fingerprint.description()
        } else {
            return nil
        }
    }
}
