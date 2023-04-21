//
//  SelectionKeyViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import UIKit

final class SelectionKeyViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterSelectionKeyProtocol!
    
    // MARK: - Private Variable
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.requestNewListKeys()
    }
    
    override func applyLocalization() {}
}

// MARK: - IBAction

private extension SelectionKeyViewController {
    
}

// MARK: - PresenterToView

extension SelectionKeyViewController: PresenterToViewSelectionKeyProtocol {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - Private

private extension SelectionKeyViewController {
    func setupUI() {
        title = "Select Key"
        
        tableView.register(EncryptListKeysCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension SelectionKeyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(EncryptListKeysCell.self, for: indexPath)
        cell.update(with: presenter.keys[indexPath.row])
        return cell
    }
}

extension SelectionKeyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKey = presenter.keys[indexPath.row]
        presenter.requestSelectedKey(selectedKey)
        navigationController?.popViewController(animated: true)
    }
}
