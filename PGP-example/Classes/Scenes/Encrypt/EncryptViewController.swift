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
    
    @IBOutlet private weak var receiverPublicKeyContainerView: UIStackView!
    @IBOutlet private weak var receiverPublicKeyFingerprintLabel: UILabel!
    @IBOutlet private weak var receiverPublicKeyTypeLabel: UILabel!
    
    @IBOutlet private weak var signerPrivateKeyContainerView: UIStackView!
    @IBOutlet private weak var signerPrivateKeyFingerprintLabel: UILabel!
    @IBOutlet private weak var signerPrivateKeyTypeLabel: UILabel!
    @IBOutlet private weak var passphraseTextField: UITextField!
    
    @IBOutlet private weak var plainTextView: UITextView!
    @IBOutlet private weak var encryptedMessageLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterEncryptProtocol!
    
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

private extension EncryptViewController {
    @IBAction func encryptMessageButtonTapped(_ sender: Any) {
        presenter.requestEncryptMessage(plainTextView.text,
                                        passphrase: passphraseTextField.text.orEmpty)
    }
    
    @IBAction func copyEncryptedMessageButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = encryptedMessageLabel.text
        makeToast("Copy encrypted message success!")
    }
}

// MARK: - PresenterToView

extension EncryptViewController: PresenterToViewEncryptProtocol {    
    func showEncryptedMessage(_ encryptedMessage: String) {
        encryptedMessageLabel.text = encryptedMessage
        makeToast("Encrypt message success!")
    }
    
    func showReceiverPublicKey(fingerprint: String, typeString: String) {
        receiverPublicKeyFingerprintLabel.text = fingerprint
        receiverPublicKeyTypeLabel.text = typeString
    }
    
    func showSignerPrivateKey(fingerprint: String, typeString: String) {
        signerPrivateKeyFingerprintLabel.text = fingerprint
        signerPrivateKeyTypeLabel.text = typeString
    }
}

// MARK: - Private

private extension EncryptViewController {
    func setupUI() {
        navigationItem.title = "Encrypt (+ Signing)"
        
        let receiverPublicKeyTap = UITapGestureRecognizer(target: self, action: #selector(showListPublicKeys))
        receiverPublicKeyContainerView.isUserInteractionEnabled = true
        receiverPublicKeyContainerView.addGestureRecognizer(receiverPublicKeyTap)
        
        let signerPrivateKeyTap = UITapGestureRecognizer(target: self, action: #selector(didTapSignerPrivateKeyBlock))
        signerPrivateKeyContainerView.isUserInteractionEnabled = true
        signerPrivateKeyContainerView.addGestureRecognizer(signerPrivateKeyTap)
    }
    
    @objc func showListPublicKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .publicKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSignerPrivateKeyBlock() {
        presenter.requestResetSignerPrivateKey()
        showSignerPrivateKey(fingerprint: "---", typeString: "---")
        showListPrivateKeys()
    }
    
    func showListPrivateKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .privateKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
