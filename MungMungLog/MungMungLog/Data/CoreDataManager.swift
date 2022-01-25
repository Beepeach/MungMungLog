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
                // TODO: Store 로드에러가 발생하면 어떻게 처리할까 고민해보자.
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
    
    func deleteAllEntities() {
        deleteEntity(name: EntityName.user.rawValue)
        deleteEntity(name: EntityName.pet.rawValue)
        deleteEntity(name: EntityName.familyMember.rawValue)
        deleteEntity(name: EntityName.history.rawValue)
        deleteEntity(name: EntityName.walkHistory.rawValue)
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

