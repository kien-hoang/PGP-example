//
//  SigningViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

final class SigningViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterSigningProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func applyLocalization() {
        
    }
}

// MARK: - IBAction

private extension SigningViewController {
    
}

// MARK: - PresenterToView

extension SigningViewController: PresenterToViewSigningProtocol {
    
}

// MARK: - Private

private extension SigningViewController {
    func setupUI() {
        
    }
}
