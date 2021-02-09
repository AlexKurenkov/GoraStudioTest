//
//  UsersPresenter.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

protocol UsersTableViewProtocol: class {
    
    func succsess(users: [User]?)
    func failure(error: Error)
}
 
protocol UsersPresenterProtocol: class {
    
    init(view: UsersTableViewProtocol?, networkDataFetcher: ApiNetworkDataFetcherProtocol?, router: ApiRouterProtocol?)
    
    var users: [User]? { get set }
    
    func getUsers()
    func didSelectCell(withUserId id: Int)
}

class UsersPresenter: UsersPresenterProtocol {

    // MARK: - Public Properties
    weak var view: UsersTableViewProtocol?
    var networkDataFetcher: ApiNetworkDataFetcherProtocol?
    var router: ApiRouterProtocol?
    var users: [User]?

    // MARK: - Initializers
    required init(view: UsersTableViewProtocol?,
                  networkDataFetcher: ApiNetworkDataFetcherProtocol?,
                  router: ApiRouterProtocol?) {
        self.view = view
        self.networkDataFetcher = networkDataFetcher
        self.router = router
        getUsers()
    }
    
    // MARK: - Public methods
    public func getUsers() {
        networkDataFetcher?.fetchUsers { [weak self] (result) in
            switch result {
            case .success(let users):
                self?.users = users
                self?.view?.succsess(users: users)
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    public func didSelectCell(withUserId id: Int) {
        router?.showAlbumsViewController(fromUserId: id)
    }
}
 
