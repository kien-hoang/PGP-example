//
//  VerifySignatureViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

final class VerifySignatureViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterVerifySignatureProtocol!
    
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

private extension VerifySignatureViewController {
    
}

// MARK: - PresenterToView

extension VerifySignatureViewController: PresenterToViewVerifySignatureProtocol {
    
}

// MARK: - Private

private extension VerifySignatureViewController {
    func setupUI() {
        
    }
}
