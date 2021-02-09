//
//  AssemblyBuilder.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

// MARK: - Application Modules Builder
protocol AssemblyBuilderProtocol {
    
    func createUsersTableViewController(router: ApiRouterProtocol?) -> UIViewController?
    func createAlbumsTableViewController(fromUserId id: Int, router: ApiRouterProtocol?) -> UIViewController?
    func createPhotosTableViewController(fromAlbumId id: Int, router: ApiRouterProtocol?) -> UIViewController?
}

struct AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createUsersTableViewController(router: ApiRouterProtocol?) -> UIViewController? {
        let view = UsersTableViewController()
        let networkDataFetcher = ApiNetworkDataFetcher()
        let presenter = UsersPresenter(view: view,
                                       networkDataFetcher: networkDataFetcher,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createAlbumsTableViewController(fromUserId id: Int, router: ApiRouterProtocol?) -> UIViewController? {
        let view = AlbumsTableViewController()
        let networkDataFetcher = ApiNetworkDataFetcher()
        let presenter = AlbumsPresenter(userId: id,
                                        view: view,
                                        networkDataFetcher: networkDataFetcher,
                                        router: router)
        view.presenter = presenter
        return view
    }
    
    func createPhotosTableViewController(fromAlbumId id: Int, router: ApiRouterProtocol?) -> UIViewController? {
        let view = PhotoTableViewController()
        let networkDataFetcher = ApiNetworkDataFetcher()
        let presenter = PhotoPresenter(albumId: id,
                                       view: view,
                                       networkDataFetcher: networkDataFetcher,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    
}
