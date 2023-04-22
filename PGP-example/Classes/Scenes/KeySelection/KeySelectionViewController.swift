//
//  KeySelectionViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 22/04/2023.
//  
//

import UIKit

final class KeySelectionViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Public Variable
    
    var presenter: ViewToPresenterKeySelectionProtocol!
    
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

private extension KeySelectionViewController {
    
}

// MARK: - PresenterToView

extension KeySelectionViewController: PresenterToViewKeySelectionProtocol {
    func updateUI(with title: String) {
        navigationItem.title = title
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - Private

private extension KeySelectionViewController {
    func setupUI() {
        tableView.register(ListKeysCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension KeySelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ListKeysCell.self, for: indexPath)
        cell.update(with: presenter.keys[indexPath.row])
        return cell
    }
}

extension KeySelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedKey = presenter.keys[indexPath.row]
        presenter.requestDidSelectKeychain(selectedKey)
        navigationController?.popViewController(animated: true)
    }
}
