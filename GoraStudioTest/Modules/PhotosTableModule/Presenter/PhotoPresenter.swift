//
//  PhotoPresenter.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

protocol PhotoTableViewProtocol: class {
    
    func success(photos: [Photo]?)
    func failure(error: Error)
}

protocol PhotoPresenterProtocol {
    
    init(albumId id: Int, view: PhotoTableViewProtocol?, networkDataFetcher: ApiNetworkDataFetcherProtocol?, router: ApiRouterProtocol?)
    
    var photos: [Photo]? { get set }
    
    func getPhotos()
}

class PhotoPresenter: PhotoPresenterProtocol {
    
    // MARK: - Public Properties
    weak var view: PhotoTableViewProtocol?
    var networkDataFetcher: ApiNetworkDataFetcherProtocol?
    var router: ApiRouterProtocol?
    var albumId: Int
    var photos: [Photo]?
    
    // MARK: - Initializers
    required init(albumId id: Int, view: PhotoTableViewProtocol?, networkDataFetcher: ApiNetworkDataFetcherProtocol?, router: ApiRouterProtocol?) {
        self.albumId = id
        self.view = view
        self.networkDataFetcher = networkDataFetcher
        self.router = router
        getPhotos()
    }
    
    // MARK: - Public methods
    public func getPhotos() {
        networkDataFetcher?.fetchPhotos(fromAlbumId: albumId) { [weak self] (result) in
            switch result {
            case .success(let photos):
                self?.photos = photos
                self?.view?.success(photos: photos)
            case .failure(let error):
                self?.view?.failure(error: error)
            }
        }
    }
}
