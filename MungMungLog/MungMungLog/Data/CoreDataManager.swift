//
//  CoreDataManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/27.
//

import Foundation
import CoreData

enum EntityName: String {
    case user = "User"
    case pet = "Pet"
    case familyMember = "FamilyMember"
    case history = "History"
    case walkHistory = "WalkHistory"
}

class  CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    var container: NSPersistentContainer?
    
    var mainContext: NSManagedObjectContext {
        guard let context = container?.viewContext else {
            fatalError()
        }
        
        return context
    }
    
    func setup(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container?.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                print(error)
            }
        })
    }
    
    func saveMainContext() {
        mainContext.perform { [self] in
            if mainContext.hasChanges {
                do {
                    try mainContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    
    func deleteEntity(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try mainContext.execute(deleteRequest)
            try mainContext.save()
        } catch {
            print(error)
        }
        
    }
    
}

