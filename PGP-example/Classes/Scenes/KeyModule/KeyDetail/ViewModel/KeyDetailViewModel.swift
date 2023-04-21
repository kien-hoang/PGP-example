//
//  KeyDetailViewModel.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//

import Foundation

struct KeyDetailViewModel {
    let id: String
    let type: String
    let expirationDate: String
    let fingerprint: String
    let armoredPublicKey: String
    let armoredPrivateKey: String
}
