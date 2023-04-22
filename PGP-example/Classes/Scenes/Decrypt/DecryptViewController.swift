//
//  DecryptViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import UIKit

final class DecryptViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var receiverPrivateKeyContainerView: UIStackView!
    @IBOutlet private weak var receiverPrivateKeyFingerprintLabel: UILabel!
    @IBOutlet private weak var receiverPrivateKeyTypeLabel: UILabel!
    @IBOutlet private weak var passphraseTextField: UITextField!
    
    @IBOutlet private weak var signerPublicKeyContainerView: UIStackView!
    @IBOutlet private weak var signerPublicKeyFingerprintLabel: UILabel!
    @IBOutlet private weak var signerPublicKeyTypeLabel: UILabel!
    
    @IBOutlet private weak var encryptedMessageTextView: UITextView!
    @IBOutlet private weak var decryptedMessageLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterDecryptProtocol!
    
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

private extension DecryptViewController {
    @IBAction func pasteEncryptedMessageFromClipboardButtonTapped(_ sender: Any) {
        encryptedMessageTextView.text = UIPasteboard.general.string
    }
    
    @IBAction func decryptButtonTapped(_ sender: Any) {
        presenter.requestDecryptTheMessage(encryptedMessageTextView.text,
                                           passphrase: passphraseTextField.text.orEmpty)
    }
}

// MARK: - PresenterToView

extension DecryptViewController: PresenterToViewDecryptProtocol {
    func showDecryptedMessage(_ decryptedMessage: String) {
        decryptedMessageLabel.text = decryptedMessage
        makeToast("Decrypt the message success!")
    }
    
    func showReceiverPrivateKey(fingerprint: String, typeString: String) {
        receiverPrivateKeyFingerprintLabel.text = fingerprint
        receiverPrivateKeyTypeLabel.text = typeString
    }
    
    func showSignerPublicKey(fingerprint: String, typeString: String) {
        signerPublicKeyFingerprintLabel.text = fingerprint
        signerPublicKeyTypeLabel.text = typeString
    }
}

// MARK: - Private

private extension DecryptViewController {
    func setupUI() {
        navigationItem.title = "Decrypt (+ Verify)"
        
        let receiverPrivateKeyTap = UITapGestureRecognizer(target: self, action: #selector(showListPrivateKeys))
        receiverPrivateKeyContainerView.isUserInteractionEnabled = true
        receiverPrivateKeyContainerView.addGestureRecognizer(receiverPrivateKeyTap)
        
        let signerPublicKeyTap = UITapGestureRecognizer(target: self, action: #selector(didTapSignerPublicKeyBlock))
        signerPublicKeyContainerView.isUserInteractionEnabled = true
        signerPublicKeyContainerView.addGestureRecognizer(signerPublicKeyTap)
    }
    
    @objc func showListPrivateKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .privateKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSignerPublicKeyBlock() {
        presenter.requestResetSignerPublicKey()
        showSignerPublicKey(fingerprint: "---", typeString: "---")
        showListPublicKeys()
    }
    
    func showListPublicKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .publicKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
