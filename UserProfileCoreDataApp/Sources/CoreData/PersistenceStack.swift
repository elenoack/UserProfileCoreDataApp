//
//  PersistenceStack.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 13.08.22.
//

import CoreData

enum CoreDataKeyPath: String {
    case userFullName = "fullName"
    case birthday = "birthday"
    case gender = "gender"
    case avatarImage = "avatarImage"
}

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
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Methods

    private lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveUser(fullName: String) {
        let userInfo = UserInfo(context: managedContext)
        userInfo.setValue(fullName, forKey: CoreDataKeyPath.userFullName.rawValue)
        guard managedContext.hasChanges
        else {
            return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error. \(error), \(error.userInfo)")
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
        guard managedContext.hasChanges
        else {
            return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateProfile(user: NSManagedObject) {
        guard managedContext.hasChanges
        else {
            return }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


