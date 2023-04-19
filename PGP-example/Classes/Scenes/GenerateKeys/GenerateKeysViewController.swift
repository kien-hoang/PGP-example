//
//  GenerateKeysViewController.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

final class GenerateKeysViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterGenerateKeysProtocol!
    
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

private extension GenerateKeysViewController {
    
}

// MARK: - PresenterToView

extension GenerateKeysViewController: PresenterToViewGenerateKeysProtocol {
    
}

// MARK: - Private

private extension GenerateKeysViewController {
    func setupUI() {
        
    }
}
