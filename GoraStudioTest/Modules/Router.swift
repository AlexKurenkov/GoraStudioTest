//
//  Router.swift
//  GoraStudioTest
//
//  Created by Александр on 08.02.2021.
//

import UIKit

protocol RouterMainProtocol {
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?)
    
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

// MARK: - ApiRouterProtocol - the abstract protocol required for routing in Application
protocol ApiRouterProtocol: RouterMainProtocol {
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?)
    
    func showInitialViewController()
    func showAlbumsViewController(fromUserId id: Int)
    func showPhotosViewController(fromAlbumId id: Int)
    func popToRoot()
}

struct ApiRouter: ApiRouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showInitialViewController() {
        if let usersTVC = assemblyBuilder?.createUsersTableViewController(router: self) {
            navigationController?.viewControllers = [usersTVC]
        }
    }
    
    func showAlbumsViewController(fromUserId id: Int) {
        if let albumsTVC = assemblyBuilder?.createAlbumsTableViewController(fromUserId: id, router: self) {
            navigationController?.pushViewController(albumsTVC, animated: true)
        }
    }
    
    func showPhotosViewController(fromAlbumId id: Int) {
        if let photosTVC = assemblyBuilder?.createPhotosTableViewController(fromAlbumId: id, router: self) {
            navigationController?.pushViewController(photosTVC, animated: true)
        }
    }
    
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }
}
