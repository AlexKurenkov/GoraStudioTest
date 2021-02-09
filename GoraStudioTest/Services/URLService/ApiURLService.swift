//
//  ApiURLService.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import Foundation

// MARK: - Application URLService attached by application needs
protocol ApiURLServiceProtocol {
    
    init (urlService: URLServiceProtocol)
    
    func getUsersURL() -> URL?
    func getAlbumsURL(fromUserId id: Int) -> URL?
    func getPhotosURL(fromAlbumsId id: Int) -> URL?
}

struct ApiURLService: ApiURLServiceProtocol {

    // MARK: - Private Properties
    private let mainURL = "https://jsonplaceholder.typicode.com/"
    private var urlService: URLServiceProtocol

    // MARK: - Initializers
    init(urlService: URLServiceProtocol = URLService()) {
        self.urlService = urlService
    }

    // MARK: - Public methods
    public func getUsersURL() -> URL? {
        guard let url = URL(string: mainURL + "users") else { return nil }
        return url
    }
    
    public func getAlbumsURL(fromUserId id: Int) -> URL? {
        let url = mainURL + "albums?"
        let idItem = URLQueryItem(name: "userId", value: "\(id)")
        return urlService.fetchUrlWithComponents(from: url, components: [idItem])
    }
    
    public func getPhotosURL(fromAlbumsId id: Int) -> URL? {
        let url = mainURL + "photos?"
        let idItem = URLQueryItem(name: "albumId", value: "\(id)")
        return urlService.fetchUrlWithComponents(from: url, components: [idItem])
    }
}
