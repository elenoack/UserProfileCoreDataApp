//
//  AssemblyModuleBuilder.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit
// MARK: - AssemblyBuilderProtocol

protocol AssemblyBuilderProtocol {
    func createUsersModule(router: RouterModule) -> UIViewController
    func createUserInfoModule(router: RouterModule,
                              userName: String) -> UIViewController
}

// MARK: - AssemblyModuleBuilder

class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createUsersModule(router: RouterModule) -> UIViewController {
        let view = UsersViewController()
        let presenter = UsersPresenter(view: view,
                                       router: router)
        view.presenter = presenter
        return view
    }
    
    func createUserInfoModule(router: RouterModule, userName: String) -> UIViewController {
        let view = UserInfoViewController()
        let presenter = UserInfoPresenter(view: view,
                                          router: router,
                                          userName: userName)
        view.presenter = presenter
        return view
    }

}
    


