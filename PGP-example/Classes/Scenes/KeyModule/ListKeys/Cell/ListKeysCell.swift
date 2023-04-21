//
//  ListKeysCell.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import UIKit

final class ListKeysCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var fingerprintLabel: UILabel!
}

// MARK: - Public

extension ListKeysCell {
    func update(with key: Keychain) {
        emailLabel.text = "KeyID: " + key.keyID.shortIdentifier
        if let fingerprint = key.publicKey?.fingerprint.description() {
            fingerprintLabel.text = "Fingerprint: " + fingerprint
        } else {
            fingerprintLabel.text = "---"
        }
    }
}
