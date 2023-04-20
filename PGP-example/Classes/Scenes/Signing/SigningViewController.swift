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
    
    override func applyLocalization() {
        
    }
}

// MARK: - IBAction

private extension SigningViewController {
    @IBAction func signMessageButtonTapped(_ sender: Any) {
        presenter.requestSigningMessage(plainTextView.text.orEmpty,
                                        passPhrase: passphraseTextField.text.orEmpty)
    }
    
    @IBAction func pastePrivateKeyFromClipboardButtonTapped(_ sender: Any) {
        privateKeyTextView.text = UIPasteboard.general.string
        makeToast("Paste private key from clipboard!")
    }
    
    @IBAction func copySignedMessageButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = signedMessageLabel.text
    }
}

// MARK: - PresenterToView

extension SigningViewController: PresenterToViewSigningProtocol {
    func showSignedMessage(_ signedMessage: String) {
        signedMessageLabel.text = signedMessage
        makeToast("Signing message success!")
    }
}

// MARK: - Private

private extension SigningViewController {
    func setupUI() {
        
    }
}
