//
//  ListKeysViewController.swift
//  PGP-example
//
//  Created by Bradley Hoang on 21/04/2023.
//  
//

import UIKit

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
        let vc = GenerateKeysBuilder.build()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - PresenterToView

extension ListKeysViewController: PresenterToViewListKeysProtocol {
    func reloadTableViewData() {
        tableView.reloadData()
    }
}

// MARK: - Private

private extension ListKeysViewController {
    func setupUI() {
        title = "List Keys"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(addKeyButtonTapped))
        
        tableView.register(ListKeysCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension ListKeysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ListKeysCell.self, for: indexPath)
        cell.update(with: presenter.keys[indexPath.row])
        return cell
    }
}

extension ListKeysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = KeyDetailBuilder.build(key: presenter.keys[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
