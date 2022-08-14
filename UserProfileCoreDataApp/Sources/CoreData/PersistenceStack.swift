//
//  PersistenceStack.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import CoreData

class PersistenceStack {
    // MARK: - Properties
    
    private let modelName: String

    // MARK: - Initialization
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Private

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("\(Strings.notSaveError). \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveUser(fullName: String) {
        let userInfo = UserInfo(context: managedContext)
        userInfo.setValue(fullName, forKey: Strings.userName)
        print(userInfo.value(forKey: Strings.userName) as? String ?? "" )
        guard managedContext.hasChanges
        else {
            return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(Strings.notSaveError). \(error), \(error.userInfo)")
        }
    }
    
    func fetchUser() -> [UserInfo]? {
        let request: NSFetchRequest = UserInfo.fetchRequest()
        do {
            let result = try? self.managedContext.fetch(request)
            return result
        }
    }
    
    func deleteUser(user: UserInfo) {
        managedContext.delete(user)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(Strings.notSaveError). \(error), \(error.userInfo)")
        }
    }
}

// MARK: - Constants

extension PersistenceStack {
    
    enum Strings {
        static let unresolvedError: String = "Unresolved error"
        static let notSaveError: String = "Could not save"
        static let userName: String = "fullName"
    }
}

