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
    
    @IBOutlet private weak var selectedKeyContainerView: UIStackView!
    @IBOutlet private weak var selectedKeyIdLabel: UILabel!
    @IBOutlet private weak var selectedFingerprintLabel: UILabel!
    
    @IBOutlet private weak var plainTextView: UITextView!
    @IBOutlet private weak var privateKeyTextView: UITextView!
    @IBOutlet private weak var passphraseTextField: UITextField!
    @IBOutlet private weak var signedMessageLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterSigningProtocol!
    
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

private extension SigningViewController {
    @IBAction func signMessageButtonTapped(_ sender: Any) {
        presenter.requestSigningMessage(plainTextView.text.orEmpty,
                                        passphrase: passphraseTextField.text.orEmpty)
    }
    
    @IBAction func pastePrivateKeyFromClipboardButtonTapped(_ sender: Any) {
        privateKeyTextView.text = UIPasteboard.general.string
        makeToast("Paste private key from clipboard!")
    }
    
    @IBAction func copySignedMessageButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = signedMessageLabel.text
        makeToast("Copy signed message success!")
    }
}

// MARK: - PresenterToView

extension SigningViewController: PresenterToViewSigningProtocol {
    func showSelectedKeyInformation(fingerprint: String, typeString: String) {
        selectedKeyIdLabel.text = fingerprint
        selectedFingerprintLabel.text = typeString
    }
    
    func showSignedMessage(_ signedMessage: String) {
        signedMessageLabel.text = signedMessage
        makeToast("Signing message success!")
    }
}

// MARK: - Private

private extension SigningViewController {
    func setupUI() {
        navigationItem.title = "Signing"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showListKeys))
        selectedKeyContainerView.isUserInteractionEnabled = true
        selectedKeyContainerView.addGestureRecognizer(tap)
    }
    
    @objc func showListKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .privateKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
