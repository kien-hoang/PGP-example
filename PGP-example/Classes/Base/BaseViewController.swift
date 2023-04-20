//
//  BaseViewController.swift
//  
//
//  Created by bradley.hoang99@gmail.com on 04/04/2023.
//

import UIKit
import Toast_Swift

class BaseViewController: UIViewController {
    
    // MARK: - Lifecycle
    
    func applyLocalization() {}
}

// MARK: - BaseViewProtocol

extension BaseViewController {
    func showLoading() {
        view.makeToastActivity(.center)
    }
    
    func finishLoading() {
        view.hideToastActivity()
    }
    
    func showError(_ error: String) {
        view.makeToast(error, duration: 1.5)
    }
}
