//
//  AlbumsPresenter.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

protocol AlbumsTableViewProtocol: class {
    
    func success(albums: [Album]?)
    func failure(error: Error)
}

protocol AlbumsPresenterProtocol {
    
    init(userId id: Int, view: AlbumsTableViewProtocol?, networkDataFetcher: ApiNetworkDataFetcherProtocol?, router: ApiRouterProtocol?)
    
    var albums: [Album]? { get set }
    
    func getAlbums()
    func didSelectCell(withAlbumId id: Int)
}

class AlbumsPresenter: AlbumsPresenterProtocol {
    
    // MARK: - Public Properties
    weak var view: AlbumsTableViewProtocol?
    var networkDataFetcher: ApiNetworkDataFetcherProtocol?
    var router: ApiRouterProtocol?
    var userId: Int
    var albums: [Album]?
    
    // MARK: - Initializers
    required init(userId id: Int,
                  view: AlbumsTableViewProtocol?,
                  networkDataFetcher: ApiNetworkDataFetcherProtocol?,
                  router: ApiRouterProtocol?) {
        self.userId = id
        self.view = view
        self.networkDataFetcher = networkDataFetcher
        self.router = router
        getAlbums()
    }
    
    // MARK: - Public methods
    public func getAlbums() {
        networkDataFetcher?.fetchAlbums(fromUserId: userId) { [weak self] (result) in
            switch result {
            case .success(let albums):
                self?.albums = albums
                self?.view?.success(albums: albums)
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
    
    public func didSelectCell(withAlbumId id: Int) {
        router?.showPhotosViewController(fromAlbumId: id)
    }
}
