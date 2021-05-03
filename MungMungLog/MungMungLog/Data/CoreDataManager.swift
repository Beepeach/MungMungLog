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
//        container = NSPersistentContainer(name: modelName)
        
        if #available(iOS 13.0, *) {
            container = NSPersistentContainer(name: modelName)
        } else {
            var modelURL = Bundle(for: type(of: self)).url(forResource: modelName, withExtension: "momd")!
            let versionInfoURL = modelURL.appendingPathComponent("VersionInfo.plist")
            if let versionInfoNSDictionary = NSDictionary(contentsOf: versionInfoURL),
                let version = versionInfoNSDictionary.object(forKey: "NSManagedObjectModel_CurrentVersionName") as? String {
                modelURL.appendPathComponent("\(version).mom")
                let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
                container = NSPersistentContainer(name: modelName, managedObjectModel: managedObjectModel!)
            } else {
                //fall back solution; runs fine despite "Failed to load optimized model" warning
                container = NSPersistentContainer(name: modelName)
            }
        }
        
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
    
    func downloadImages(url: URL) {
        if let fileName = url.absoluteString.components(separatedBy: "/").last {
            if var localUrl = FileManager.cacheDirectoryUrl?.appendingPathComponent(fileName) {
                do {
                    let exist = FileManager.default.fileExists(atPath: localUrl.absoluteString)
                    if !exist {
                        let data = try Data(contentsOf: url)
                        try data.write(to: localUrl)
                        
                        localUrl.excludedFromBackup()
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
}

