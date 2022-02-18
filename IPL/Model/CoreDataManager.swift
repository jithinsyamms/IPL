//
//  CoreDataManager.swift
//  IPL
//
//  Created by Jithin on 15/02/22.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private init() {
    }

    private lazy var storeContainer: NSPersistentContainer = {
        let storeContainer = NSPersistentContainer(name: "IPL")
        storeContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error  = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return storeContainer
    }()



    func getManagedContext() -> NSManagedObjectContext {
        return storeContainer.viewContext
    }

    func saveContext() {
        guard storeContainer.viewContext.hasChanges else {return}

        do {
            try storeContainer.viewContext.save()
        } catch let error as NSError {
            print("Error \(error), \(error.userInfo)")
        }
    }
}
