//
//  UserInfo+CoreDataProperties.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var logi: String?
    @NSManaged public var ava: String?
    @NSManaged public var repos: String?
    @NSManaged public var name: String?
    @NSManaged public var company: String?
    @NSManaged public var location: String?
    @NSManaged public var email: String?
    @NSManaged public var user: User?
    @NSManaged public var reposit: NSSet?

    
    var getRepod: [Repos] {
        get {
            return reposit?.allObjects as? [Repos] ?? []
        }
    }
}

// MARK: Generated accessors for reposit
extension UserInfo {

    @objc(addRepositObject:)
    @NSManaged public func addToReposit(_ value: Repos)

    @objc(removeRepositObject:)
    @NSManaged public func removeFromReposit(_ value: Repos)

    @objc(addReposit:)
    @NSManaged public func addToReposit(_ values: NSSet)

    @objc(removeReposit:)
    @NSManaged public func removeFromReposit(_ values: NSSet)

}

extension UserInfo : Identifiable {

}
