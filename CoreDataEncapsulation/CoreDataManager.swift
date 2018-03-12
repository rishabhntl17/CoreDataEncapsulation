//
//  CoreDataManager.swift
//  CoreDataEncapsulation
//
//  Created by Appinventiv on 3/8/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//
import UIKit
import Foundation
import CoreData

class CoreDataManager {
    
     static private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class func getUser(entityName : String) -> NSManagedObject
    {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)
        return NSManagedObject(entity: entity!, insertInto: managedContext)
    }
    
    class func saveData(entityName : String) {
        
        do {
            try managedContext.save()
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    class func getData(entityName : String) -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        //let predicate = NSPredicate(format: "name == %@", "Gurdeep")
        //request.predicate = predicate
        return try! managedContext.fetch(request)
    }
    
    class func deleteData(entityName : String, toDelete : String) {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        //request.returnsObjectsAsFaults = false
        do
        {
            let allUsers = try managedContext.fetch(request)
            for user in allUsers
            {
                if toDelete == (user.value(forKey: "name") as! String)
                {
                    managedContext.delete(user)
                    try managedContext.save()
                }
            }
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    class func deleteAllData(entityName : String)
    {
        let request = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do
        {
            let allUsers = try managedContext.fetch(request)
            for user in allUsers
            {
                    managedContext.delete(user)
                    try managedContext.save()
            }
        }
        catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
