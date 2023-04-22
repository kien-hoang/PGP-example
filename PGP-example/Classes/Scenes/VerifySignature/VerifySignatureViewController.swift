//
//  VerifySignatureViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 19/04/2023.
//  
//

import UIKit

// FIXME: Archived

final class VerifySignatureViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var signedMessageTextView: UITextView!
    @IBOutlet private weak var publicKeyTextView: UITextView!
    @IBOutlet private weak var rawMessageLabel: UILabel!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterVerifySignatureProtocol!
    
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

private extension VerifySignatureViewController {
    @IBAction func verifySignatureButtonTapped(_ sender: Any) {
        presenter.requestVerifySignature(signedMessageTextView.text.orEmpty)
    }
    
    @IBAction func pasteSignedMessageButtonTapped(_ sender: Any) {
        signedMessageTextView.text = UIPasteboard.general.string
    }
    
    @IBAction func pastePublicKeyFromClipboardButtonTapped(_ sender: Any) {
        publicKeyTextView.text = UIPasteboard.general.string
    }
}

// MARK: - PresenterToView

extension VerifySignatureViewController: PresenterToViewVerifySignatureProtocol {
    
}

// MARK: - Private

private extension VerifySignatureViewController {
    func setupUI() {
        
    }
}
