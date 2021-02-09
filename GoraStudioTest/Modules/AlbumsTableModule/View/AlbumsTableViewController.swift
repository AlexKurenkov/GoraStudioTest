//
//  AlbumsTableViewController.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class AlbumsTableViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // MARK: - Public Properties
    var presenter: AlbumsPresenterProtocol?

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
        tableView.register(UINib(nibName: "AlbumsTableViewCell", bundle: nil), forCellReuseIdentifier: Constans.TableCellIdentifiers.albumTableViewCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constans.UIConstants.estimatedAlbumTableViewCellHeight
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Albums"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITabelViewDelegate
extension AlbumsTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = presenter?.albums?[indexPath.row].id else { return }
        presenter?.didSelectCell(withAlbumId: id)
    }
}

// MARK: - UITableViewDataSource
extension AlbumsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.TableCellIdentifiers.albumTableViewCellIdentifier, for: indexPath) as? AlbumsTableViewCell else { return UITableViewCell() }
        cell.setupAlbumsTableViewCell(fromAlbum: presenter?.albums?[indexPath.row], index: indexPath.row + 1)
        return cell
    }
}

// MARK: - AlbumsTableViewProtocol
extension AlbumsTableViewController: AlbumsTableViewProtocol {
    func success(albums: [Album]?) {
        tableView.performBatchUpdates {
            let insertedIndexPath = IndexPath.getInsertedIndexPaths(to: albums)
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
            self?.presenter?.getAlbums()
        } cancelHandler: { [weak self] _ in
            self?.indicator.stopAnimating()
        }
        present(controller, animated: true, completion: nil)
    }
    
}
