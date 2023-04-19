//
//  String+Extensions.swift
//
//
//  Created by bradley.hoang99@gmail.com on 04/04/2023.
//

import Foundation

extension String {
    var asTrimmed: String {
        trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func escape() -> String {
        let allowedCharacters = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return allowedCharacters
    }
}
