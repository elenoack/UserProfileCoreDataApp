//
//  RouterModule.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit
// MARK: - RouterUser

protocol RouterUser {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

// MARK: - RouterProtocol

protocol RouterProtocol: RouterUser {
    func initViewController()
    func openUserInfoViewController(userName: String)
}

// MARK: - RouterModule

class RouterModule: RouterProtocol {
    
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    // MARK: - Methods
    
    func initViewController() {
        if let navigationController = navigationController {
            guard let usersViewController = assemblyBuilder?.createUsersModule(router: self)
            else {
                return }
            navigationController.viewControllers = [usersViewController]
        }
    }
    
    func openUserInfoViewController(userName: String) {
        guard let userInfoViewController = assemblyBuilder?.createUserInfoModule(router: self,
                                                                                 userName: userName)
        else {
            return }
        navigationController?.pushViewController(userInfoViewController, animated: true)
    }
    
}


