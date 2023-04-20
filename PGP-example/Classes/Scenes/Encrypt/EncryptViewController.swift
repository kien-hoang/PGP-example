//
//  EncryptViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 20/04/2023.
//  
//

import UIKit

final class EncryptViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterEncryptProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func applyLocalization() {
        
    }
}

// MARK: - IBAction

private extension EncryptViewController {
    @IBAction func encryptMessageButtonTapped(_ sender: Any) {
        presenter.requestEncryptMessage("")
    }
}

// MARK: - PresenterToView

extension EncryptViewController: PresenterToViewEncryptProtocol {
    
}

// MARK: - Private

private extension EncryptViewController {
    func setupUI() {
        
    }
}
