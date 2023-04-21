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
    
    @IBOutlet private weak var publicKeyTextView: UITextView!
    @IBOutlet private weak var privateKeyTextView: UITextView!
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
    
    override func applyLocalization() {
        
    }
}

// MARK: - IBAction

private extension EncryptViewController {
    @IBAction func encryptMessageButtonTapped(_ sender: Any) {
        presenter.requestEncryptMessage(plainTextView.text,
                                        publicKeyString: publicKeyTextView.text,
                                        privateKeyString: privateKeyTextView.text,
                                        passphrase: passphraseTextField.text.orEmpty)
    }
    
    @IBAction func pastePublicKeyFromClipboardButtonTapped(_ sender: Any) {
        publicKeyTextView.text = UIPasteboard.general.string
        makeToast("Paste public key from clipboard success!")
    }
    
    @IBAction func pastePrivateKeyFromClipboardButtonTapped(_ sender: Any) {
        privateKeyTextView.text = UIPasteboard.general.string
        makeToast("Paste private key from clipboard success!")
    }
    
    @IBAction func copyEcryptedMessageButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = encryptedMessageLabel.text
        makeToast("Copy ecrypted message success!")
    }
}

// MARK: - PresenterToView

extension EncryptViewController: PresenterToViewEncryptProtocol {
    func showEncryptedMessage(_ encryptedMessage: String) {
        encryptedMessageLabel.text = encryptedMessage
    }
}

// MARK: - Private

private extension EncryptViewController {
    func setupUI() {
        
    }
}
