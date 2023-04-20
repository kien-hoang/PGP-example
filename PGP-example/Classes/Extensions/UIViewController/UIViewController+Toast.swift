//
//  UIViewController+Toast.swift
//  PGP-example
//
//  Created by bradley.hoang99@gmail.com on 20/04/2023.
//

import UIKit
import Toast_Swift

extension UIViewController {
    func makeToast(_ message: String?, duration: TimeInterval = 1.5) {
        view.makeToast(message, duration: duration)
    }
}
