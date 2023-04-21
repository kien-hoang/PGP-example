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
    
    @IBOutlet private weak var selectedKeyContainerView: UIStackView!
    @IBOutlet private weak var selectedKeyIdLabel: UILabel!
    @IBOutlet private weak var selectedFingerprintLabel: UILabel!
    
    @IBOutlet private weak var passphraseTextField: UITextField!
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
    func showSelectedKeyInformation(id: String, fingerprint: String) {
        selectedKeyIdLabel.text = id
        selectedFingerprintLabel.text = fingerprint
    }
    
    func showDecryptedMessage(_ decryptedMessage: String) {
        decryptedMessageLabel.text = decryptedMessage
    }
}

// MARK: - Private

private extension DecryptViewController {
    func setupUI() {
        title = "Decrypt"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showListKeys))
        selectedKeyContainerView.isUserInteractionEnabled = true
        selectedKeyContainerView.addGestureRecognizer(tap)
    }
    
    @objc func showListKeys() {
        let vc = SelectionKeyBuilder.build(delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
