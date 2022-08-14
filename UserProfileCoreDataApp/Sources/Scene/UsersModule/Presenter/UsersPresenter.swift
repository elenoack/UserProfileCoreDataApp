//
//  UsersPresenter.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import Foundation
// MARK: - UsersViewProtocol

protocol UsersViewProtocol: AnyObject {
    func reload()
}

// MARK: - UsersPresenterProtocol

protocol UsersPresenterProtocol: AnyObject {
    init(view: UsersViewProtocol,
         router: RouterProtocol)
    var userInfo: [UserInfo]? { get set }
    func saveFullName(name: String)
    func updateUsers()
    func deleteUser(userName: UserInfo)
}

// MARK: - UsersPresenter

class UsersPresenter: UsersPresenterProtocol {
   
    // MARK: - Properties
    
    let view: UsersViewProtocol?
    var router: RouterProtocol?
    var userInfo: [UserInfo]?
    
    // MARK: - Initialization
    
    required init(view: UsersViewProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.router = router
        updateUsers()
    }
    
    // MARK: - Private
    
    func updateUsers() {
        guard let users = AppDelegate.sharedAppDelegate.persistenceStack.fetchUser() else { return }
        self.userInfo = users
    }
    
    func saveFullName(name: String) {
        AppDelegate.sharedAppDelegate.persistenceStack.saveUser(fullName: name)
        self.view?.reload()
    }

    func deleteUser(userName: UserInfo) {
        AppDelegate.sharedAppDelegate.persistenceStack.deleteUser(user: userName)
        self.view?.reload()
    }

}
