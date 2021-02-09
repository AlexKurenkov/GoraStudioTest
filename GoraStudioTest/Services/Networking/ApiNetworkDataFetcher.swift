//
//  ApiNetworkDataFetcher.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

// MARK: - NetworkDataFetcher attached by application needs
protocol ApiNetworkDataFetcherProtocol {
    
    init (networkDataFetcher: NetworkDataFetcherProtocol, urlService: ApiURLServiceProtocol)
    
    func fetchUsers(completion: @escaping (Result<[User]?, Error>) -> ())
    func fetchAlbums(fromUserId id: Int, completion: @escaping (Result<[Album]?, Error>) -> ())
    func fetchPhotos(fromAlbumId id: Int, completion: @escaping (Result<[Photo]?, Error>) -> ())
    func fetchImage(fromUrl url: URL, completion: @escaping (Result<UIImage?, Error>) -> ())
    func fetchImage(fromUrl url: String, completion: @escaping (Result<UIImage?, Error>) -> ())
}

struct ApiNetworkDataFetcher: ApiNetworkDataFetcherProtocol {
    
    // MARK: - Private Properties
    private var networkDataFetcher: NetworkDataFetcherProtocol
    private var urlService: ApiURLServiceProtocol
    
    // MARK: - Initializers
    init(networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher(),
         urlService: ApiURLServiceProtocol = ApiURLService()) {
        self.networkDataFetcher = networkDataFetcher
        self.urlService = urlService
    }
    
    // MARK: - Public methods
    public func fetchUsers(completion: @escaping (Result<[User]?, Error>) -> ()) {
        guard let url = urlService.getUsersURL() else { return }
        networkDataFetcher.fetchDecodedData(from: url, completion: completion)
    }
    
    public func fetchAlbums(fromUserId id: Int, completion: @escaping (Result<[Album]?, Error>) -> ()) {
        guard let url = urlService.getAlbumsURL(fromUserId: id) else { return }
        networkDataFetcher.fetchDecodedData(from: url, completion: completion)
    }
    
    public func fetchPhotos(fromAlbumId id: Int, completion: @escaping (Result<[Photo]?, Error>) -> ()) {
        guard let url = urlService.getPhotosURL(fromAlbumsId: id) else { return }
        networkDataFetcher.fetchDecodedData(from: url, completion: completion)
    }
    
    public func fetchImage(fromUrl url: URL, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        networkDataFetcher.fetchData(from: url) { (result) in
            switch result {
            case .success(let data):
                if let data = data {
                    completion(.success(UIImage(data: data)))
                } else {
                    completion(.failure(NetworkError.noDataReceived))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchImage(fromUrl url: String, completion: @escaping (Result<UIImage?, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        fetchImage(fromUrl: url, completion: completion)
    }
}
