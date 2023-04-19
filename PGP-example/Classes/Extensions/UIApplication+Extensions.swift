//
//  UIApplication+Extensions.swift
//
//
//  Created by bradley.hoang99@gmail.com on 04/04/2023.
//

import UIKit

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.first { $0.isKeyWindow }
        } else {
            return keyWindow
        }
    }
}
