//
//  User+CoreDataProperties.swift
//  CoreDataEncapsulation
//
//  Created by Appinventiv on 3/8/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequestUser() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var mobile: String?

}
