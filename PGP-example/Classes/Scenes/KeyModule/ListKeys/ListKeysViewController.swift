//
//  ListKeysViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

final class ListKeysViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterListKeysProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.requestNewListKeys()
    }
    
    override func applyLocalization() {
        
    }
}

// MARK: - Action

private extension ListKeysViewController {
    @objc func addKeyButtonTapped(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil,
                                           message: nil,
                                           preferredStyle: .actionSheet)
        
        let generateKey = UIAlertAction(title: "Generate Key Pair",
                                        style: .default) { [weak self] _ in
            optionMenu.dismiss(animated: true, completion: nil)
            let vc = KeyGenerationBuilder.build()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        optionMenu.addAction(generateKey)
        
        let importKeyFromFile = UIAlertAction(title: "Import Keys from File",
                                              style: .default) { [weak self] _ in
            self?.importKeysFilePicker()
            optionMenu.dismiss(animated: true)
        }
        optionMenu.addAction(importKeyFromFile)
        
        let addKeyFromClipboard = UIAlertAction(title: "Add Key from Clipboard",
                                                style: .default) { [weak self] _ -> Void in
            self?.presenter.requestAddKey(UIPasteboard.general.string.orEmpty)
            optionMenu.dismiss(animated: true)
        }
        optionMenu.addAction(addKeyFromClipboard)
        
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel) { _ in
            optionMenu.dismiss(animated: true)
        }
        optionMenu.addAction(cancel)
        
        present(optionMenu, animated: true)
    }
}

// MARK: - PresenterToView

extension ListKeysViewController: PresenterToViewListKeysProtocol {
    func reloadTableViewData() {
        tableView.reloadData()
    }
    
    func showImportKeySuccessMessage(_ message: String) {
        makeToast(message)
    }
}

// MARK: - Private

private extension ListKeysViewController {
    func setupUI() {
        navigationItem.title = "List Keys"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addKeyButtonTapped))
        
        tableView.register(KeychainTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func importKeysFilePicker() {
//        let supportedTypes: [UTType] = [.data]
//        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes)
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeData as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        present(documentPicker, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension ListKeysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(KeychainTableViewCell.self, for: indexPath)
        cell.update(with: presenter.keys[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListKeysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = KeyDetailBuilder.build(key: presenter.keys[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UIDocumentPickerDelegate

extension ListKeysViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        presenter.requestDocumentPicker(didPickAt: urls)
    }
}
