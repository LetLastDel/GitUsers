//
//  User+CoreDataProperties.swift
//  GitUsers
//
//  Created by A.Stelmakh on 10.07.2023.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatar: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageData: Data?
    @NSManaged public var login: String?
    @NSManaged public var url: String?
    @NSManaged public var userinfo: NSSet?

    var getUser: [UserInfo] {
        get {
            return userinfo?.allObjects as? [UserInfo] ?? []
        }
    }
}

// MARK: Generated accessors for userinfo
extension User {

    @objc(addUserinfoObject:)
    @NSManaged public func addToUserinfo(_ value: UserInfo)

    @objc(removeUserinfoObject:)
    @NSManaged public func removeFromUserinfo(_ value: UserInfo)

    @objc(addUserinfo:)
    @NSManaged public func addToUserinfo(_ values: NSSet)

    @objc(removeUserinfo:)
    @NSManaged public func removeFromUserinfo(_ values: NSSet)

}

extension User : Identifiable {

}
