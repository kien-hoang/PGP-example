//
//  KeyGenerationViewController.swift
//  DemoPGP
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit
import Toast_Swift

final class KeyGenerationViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passphraseTextField: UITextField!
    @IBOutlet private weak var publicKeyLabel: UILabel!
    @IBOutlet private weak var privateKeyLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterKeyGenerationProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension KeyGenerationViewController {
    @IBAction func generatePairKeysButtonTapped(_ sender: Any) {
        presenter.requestGeneratePairKeys(email: emailTextField.text.orEmpty,
                                          passphrase: passphraseTextField.text.orEmpty)
    }
    
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

extension KeyGenerationViewController: PresenterToViewKeyGenerationProtocol {
    func showPairKeys(publicKey: String?, privateKey: String?) {
        publicKeyLabel.text = publicKey
        privateKeyLabel.text = privateKey
        makeToast("Generate pair keys success!")
    }
}

// MARK: - Private

private extension KeyGenerationViewController {
    func setupUI() {
        title = "Generate new Keychain"
    }
}
