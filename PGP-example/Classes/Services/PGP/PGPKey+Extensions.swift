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
    
    func getShortFingerprint() -> String? {
        guard let fingerprint = getFingerprint() else { return nil }
        let shortFingerprint = Array(fingerprint)[0..<5] + " ... " + Array(fingerprint)[(fingerprint.count - 5)...]
        return String(shortFingerprint)
    }
    
    func getKeyType() -> String {
        var type = "None"
        if self.isPublic && self.isSecret {
            type = "Public & Private"
        } else if self.isPublic {
            type = "Public"
        } else if self.isSecret {
            type = "Private"
        }
        return type
    }
}
