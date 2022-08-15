//
//  UserInfoPresenter.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 14.08.22.
//

import Foundation
// MARK: - UserInfoViewProtocol

protocol UserInfoViewProtocol: AnyObject {
   func reload()
}

// MARK: - UsersPresenterProtocol

protocol UserInfoPresenterProtocol: AnyObject {
    init(view: UserInfoViewProtocol,
         router: RouterProtocol,
         userName: String)
    var user: UserInfo? { get set }
    func saveUser(user: UserInfo)
}

// MARK: - UsersPresenter

class UserInfoPresenter: UserInfoPresenterProtocol {
    // MARK: - Properties
    
    let view: UserInfoViewProtocol?
    var router: RouterProtocol?
    let userName: String
    var user: UserInfo?
    
    // MARK: - Initialization
    
    required init(view: UserInfoViewProtocol,
                  router: RouterProtocol,
                  userName: String) {
        self.view = view
        self.router = router
        self.userName = userName
        fetchUser(userName: userName)
    }
    
    // MARK: - Methods
    
    func fetchUser(userName: String) {
        guard let users = AppDelegate.sharedAppDelegate.persistenceStack.fetchUser()
        else {
            return }
        for user in users where user.fullName == self.userName {
            self.user = user
        }
        self.view?.reload()
    }
    
    func saveUser(user: UserInfo) {
        AppDelegate.sharedAppDelegate.persistenceStack.updateProfile(user: user)
    }
    
}
