//
//  NetworkDataFetcher.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - Base NetworkDataFetcher. fetch data with NetworkService requests, fetch decoded data, decoded by JSONDecoder
protocol NetworkDataFetcherProtocol {
    
    init (networkService: NetworkServiceProtocol)
    
    func fetchData(from url: URL, completion: @escaping (Result<Data?,Error>) -> ())
    func fetchData(from url: String, completion: @escaping (Result<Data?,Error>) -> ())
    func fetchDecodedData <T: Decodable> (from url: URL, completion: @escaping (Result<T?,Error>) -> ())
    func fetchDecodedData <T: Decodable> (from url: String, completion: @escaping (Result<T?,Error>) -> ())
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    // MARK: - Private Properties
    private var networkService: NetworkServiceProtocol
    
    // MARK: - Initializers
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    // MARK: - Public methods
    public func fetchData(from url: URL, completion: @escaping (Result<Data?, Error>) -> ()) {
        networkService.request(url: url, completion: completion)
    }
    
    public func fetchData(from url: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        networkService.request(url: url, completion: completion)
    }
    
    public func fetchDecodedData<T>(from url: URL, completion: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        networkService.request(url: url) { (result) in
            switch result {
            case .success(let data):
                let decodedData = JSONDecoder.getDecodedData(type: T.self, from: data)
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchDecodedData<T>(from url: String, completion: @escaping (Result<T?, Error>) -> ()) where T : Decodable {
        guard let url = URL(string: url) else { return }
        fetchDecodedData(from: url, completion: completion)
    }
}
