//
//  SettingsViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import UIKit

final class SettingsViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterSettingsProtocol!
    
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

private extension SettingsViewController {
    @IBAction func exportKeychainButtonTapped(_ sender: Any) {
        presenter.requestExportKeychain()
    }
}

// MARK: - PresenterToView

extension SettingsViewController: PresenterToViewSettingsProtocol {
    func showExportActivitySuccessPopup(with fileUrl: URL) {
        let filesToShare: [Any] = [fileUrl]
        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        present(activityViewController, animated: true)
    }
}

// MARK: - Private

private extension SettingsViewController {
    func setupUI() {
        title = "Settings"
    }
}
