//
//  Repos+CoreDataProperties.swift
//  GitUsers
//
//  Created by A.Stelmakh on 7.07.2023.
//
//

import Foundation
import CoreData


extension Repos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repos> {
        return NSFetchRequest<Repos>(entityName: "Repos")
    }

    @NSManaged public var descripti: String?
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var archieved: Bool
    @NSManaged public var info: UserInfo?

}

extension Repos : Identifiable {

}
