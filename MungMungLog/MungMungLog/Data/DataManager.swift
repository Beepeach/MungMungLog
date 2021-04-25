//
//  DataManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/25.
//

import Foundation
import CoreData

class  DataManager {
    static let shared = DataManager()
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
    
}
