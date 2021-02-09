//
//  UsersTableViewController.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class UsersTableViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    // MARK: - Public Properties
    var presenter: UsersPresenterProtocol?

    // MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preSetup()
        setupTableView()
        setupNavigationBar()
    }

    // MARK: - Private Methods
    private func preSetup() {
        indicator.startAnimating()
        tableView.isHidden = true
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: Constans.TableCellIdentifiers.userTableViewCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constans.UIConstants.estimatedUserTableViewCellHeight
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Users"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDelegate
extension UsersTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = presenter?.users?[indexPath.row].id else { return }
        presenter?.didSelectCell(withUserId: id)
    }
}

// MARK: - UITableViewDataSource
extension UsersTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.TableCellIdentifiers.userTableViewCellIdentifier, for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        cell.setupUserTableViewCell(fromUser: presenter?.users?[indexPath.row])
        return cell
    }
}

// MARK: - UsersTableViewProtocol
extension UsersTableViewController: UsersTableViewProtocol {
    func succsess(users: [User]?) {
        tableView.performBatchUpdates {
            let insertedIndexPath = IndexPath.getInsertedIndexPaths(to: users)
            tableView.insertRows(at: insertedIndexPath, with: .automatic)
        } completion: { [weak self] (completion) in
            if completion {
                self?.indicator.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
    }
    
    func failure(error: Error) {
        let controller = UIAlertController.applicationErrorAlert(controllerTitle: "Ooops. Something Wrong", cotrollerMessage: "\(error.localizedDescription)", actionTitle: "reload", cancelActionTitle: "cancel") { [weak self] _ in
            self?.presenter?.getUsers()
        } cancelHandler: { [weak self] _ in
            self?.indicator.stopAnimating()
        }
        present(controller, animated: true, completion: nil)
    }
}
