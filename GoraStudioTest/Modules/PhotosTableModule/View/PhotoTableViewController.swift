//
//  PhotoTableViewController.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

class PhotoTableViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Public Properties
    var presenter: PhotoPresenterProtocol?

    // MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
    }

    // MARK: - Private Methods
    private func setupTableView() {
        tableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: Constans.TableCellIdentifiers.photoTableViewCellIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Constans.UIConstants.estimatedPhotoTableViewCellHeight
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Photos"
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - UITableViewDelegate
extension PhotoTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == presenter?.photos?.count {
            print ("here")
        }
    }
}

// MARK: - UITableViewDataSource
extension PhotoTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.photos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constans.TableCellIdentifiers.photoTableViewCellIdentifier, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
        cell.setupPhotoCell(fromPhoto: presenter?.photos?[indexPath.row])
        return cell
    }
}

// MARK: - PhotoTableViewProtocol
extension PhotoTableViewController: PhotoTableViewProtocol {
    func success(photos: [Photo]?) {
        tableView.performBatchUpdates {
            let insertedIndexPath = IndexPath.getInsertedIndexPaths(to: photos)
            tableView.insertRows(at: insertedIndexPath, with: .automatic)
        } completion: { [weak self] (completion) in
            if completion {
                self?.tableView.isHidden = false
            }
        }
    }
    
    func failure(error: Error) {
        let controller = UIAlertController.applicationErrorAlert(controllerTitle: "Ooops. Something Wrong", cotrollerMessage: "\(error.localizedDescription)", actionTitle: "reload", cancelActionTitle: "cancel", actionHandler:  { [weak self] _ in
            self?.presenter?.getPhotos()
        })
        present(controller, animated: true, completion: nil)
    }
}
