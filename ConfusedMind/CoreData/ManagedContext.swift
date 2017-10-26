//
//  ManagedContext.swift
//  ConfusedMind
//
//  Created by Satish Birajdar on 2017-10-18.
//  Copyright © 2017 SBSoftwares. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ManagedContext {
//    var appDelegate: AppDelegate
    //1
//    guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//    return
//    }
//
   var items : [NSManagedObject] = []
    
    var managedContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    func setManagedContext() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
         self.managedContext = appDelegate.persistentContainer.viewContext

    }
    
    func fetchItems() -> [NSManagedObject] {
        
        setManagedContext()
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        //3
        do {
            self.items = try self.managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return self.items
    }
//
//    func itemToSave(name: String){
//
//    }
//
//    func saveItem(name: String) {
//        let entity =
//            NSEntityDescription.entity(forEntityName: "Item",
//                                       in: self.managedContext)!
//
//        let item = NSManagedObject(entity: entity,
//                                   insertInto: self.managedContext)
//
//        item.setValue(name, forKeyPath: "name")
//
//        do {
//            try self.managedContext.save()
////            self.items.append(item)
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//        }
//    }
//
    
    
    
}
