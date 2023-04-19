//
//  Optional+Extensions.swift
//
//
//  Created by bradley.hoang99@gmail.com on 04/04/2023.
//

import Foundation

extension Optional where Wrapped == String {
    var orEmpty: String {
        return self ?? ""
    }
}
