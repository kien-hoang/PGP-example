//
//  KeyDetailViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import UIKit

final class KeyDetailViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var expirationDateLabel: UILabel!
    @IBOutlet private weak var fingerprintLabel: UILabel!
    @IBOutlet private weak var publicKeyLabel: UILabel!
    @IBOutlet private weak var privateKeyLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterKeyDetailProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.requestShowKeyInformation()
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension KeyDetailViewController {
    @IBAction func copyPublicKeyButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = publicKeyLabel.text
        makeToast("Copy public key success!")
    }
    
    @IBAction func copyPrivateKeyButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = privateKeyLabel.text
        makeToast("Copy private key success!")
    }
}

// MARK: - PresenterToView

extension KeyDetailViewController: PresenterToViewKeyDetailProtocol {
    func showKeyInformation(viewModel: KeyDetailViewModel) {
        idLabel.text = viewModel.id
        typeLabel.text = viewModel.type
        expirationDateLabel.text = viewModel.expirationDate
        fingerprintLabel.text = viewModel.fingerprint
        publicKeyLabel.text = viewModel.armoredPublicKey
        privateKeyLabel.text = viewModel.armoredPrivateKey
    }
}

// MARK: - Private

private extension KeyDetailViewController {
    func setupUI() {
        
    }
}
