//
//  AppDelegate.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
   
    lazy var persistenceStack: PersistenceStack = .init(modelName: "CoreDataModel")
    
    static let sharedAppDelegate: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
        }
        return delegate
    }()
    
    var window: UIWindow?
    let navigationController = UINavigationController()
    let assemblyBuilder = AssemblyModuleBuilder()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let router = RouterModule(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initViewController()
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}
  
