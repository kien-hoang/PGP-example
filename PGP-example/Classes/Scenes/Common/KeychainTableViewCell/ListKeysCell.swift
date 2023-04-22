//
//  ListKeysCell.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import UIKit

final class ListKeysCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var fingerprintLabel: UILabel!
    @IBOutlet private weak var keyTypeLabel: UILabel!
}

// MARK: - Public

extension ListKeysCell {
    func update(with key: Keychain) {
        fingerprintLabel.text = "Fingerprint: \(key.getShortFingerprint() ?? "not found")"
        keyTypeLabel.text = "Type: \(key.getKeyType())"
    }
}
