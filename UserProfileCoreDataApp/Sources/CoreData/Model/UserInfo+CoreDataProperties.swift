//
//  UserInfo+CoreDataProperties.swift
//  UserProfileCoreDataApp
//
//  Created by Elena Noack on 14.08.22.
//
//

import Foundation
import CoreData
import UIKit

extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var avatarImage: Data?
    @NSManaged public var birthday: Date?
    @NSManaged public var fullName: String?
    @NSManaged public var gender: String?
}

extension UserInfo : Identifiable {

}
