//
//  VerifySignatureViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

final class VerifySignatureViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var signerPublicKeyContainerView: UIStackView!
    @IBOutlet private weak var signerPublicKeyFingerprintLabel: UILabel!
    @IBOutlet private weak var signerPublicKeyTypeLabel: UILabel!
    
    @IBOutlet private weak var signedMessageTextView: UITextView!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterVerifySignatureProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension VerifySignatureViewController {
    @IBAction func verifySignatureButtonTapped(_ sender: Any) {
        presenter.requestVerifySignature(signedMessageTextView.text.orEmpty)
    }
    
    @IBAction func pasteSignedMessageButtonTapped(_ sender: Any) {
        signedMessageTextView.text = UIPasteboard.general.string
    }
}

// MARK: - PresenterToView

extension VerifySignatureViewController: PresenterToViewVerifySignatureProtocol {
    func showSignerPublicKey(fingerprint: String, typeString: String) {
        signerPublicKeyFingerprintLabel.text = fingerprint
        signerPublicKeyTypeLabel.text = typeString
    }
    
    func showVerifySignatureSuccessMessage(_ message: String) {
        makeToast(message)
    }
}

// MARK: - Private

private extension VerifySignatureViewController {
    func setupUI() {
        navigationItem.title = "Verify Signing"
        
        let signerPublicKeyTap = UITapGestureRecognizer(target: self, action: #selector(showListPublicKeys))
        signerPublicKeyContainerView.isUserInteractionEnabled = true
        signerPublicKeyContainerView.addGestureRecognizer(signerPublicKeyTap)
    }
    
    @objc func showListPublicKeys() {
        let vc = KeySelectionBuilder.build(keychainType: .publicKey,
                                           delegate: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
}
