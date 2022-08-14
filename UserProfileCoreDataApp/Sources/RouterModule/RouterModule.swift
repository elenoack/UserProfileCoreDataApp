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
//    func openUserInfoViewController(rocketId: String,
//                      viewController: UIViewController,
//                      rocketName: String)

//    var saveCompletion: (() -> Void)? { get set }
}

// MARK: - RouterModule

class RouterModule: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    var saveCompletion: (() -> Void)?
    
    // MARK: - Initialization
    
    init(navigationController: UINavigationController,
         assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    // MARK: - Private
    
    func initViewController() {
        if let navigationController = navigationController {
            guard let usersViewController = assemblyBuilder?.createUsersModule(router: self)
            else {
                return }
            navigationController.viewControllers = [usersViewController]
        }
    }
    
//    func openLaunchVC(rocketId: String,
//                      viewController: UIViewController,
//                      rocketName: String) {
//        guard let launchListViewController = assemblyBuilder?.createLaunchListModule(router: self, rocketId: rocketId, rocketName: rocketName)
//        else {
//            return }
//        viewController.navigationController?.pushViewController(launchListViewController, animated: true)
//        let backButton = UIBarButtonItem()
//        backButton.title = "Назад"
//        launchListViewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
//    }
//
//    func openSettingsVC(viewController: UIViewController) {
//        guard let settingsListViewController = assemblyBuilder?.createSettingModule(router: self)
//        else {
//            return }
//        let navController = UINavigationController(rootViewController: settingsListViewController)
//        navController.navigationBar.topItem?.title = "Настройки"
//        viewController.navigationController?.present(navController, animated: true)
//    }
//
//    func backToRootVC(viewController: UIViewController) {
//        viewController.navigationController?.popToRootViewController(animated: true)
//    }
//
//    func backToRootVCModal(viewController: UIViewController) {
//        viewController.navigationController?.dismiss(animated: true, completion: saveCompletion)
//    }
}


