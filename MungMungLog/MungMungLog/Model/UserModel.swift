//
//  UserModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/22.
//

import Foundation
import CoreData
import SwiftKeychainWrapper

struct User: Codable {
    let id: String
    let nickname: String
    let relationship: String
    let gender: Bool
    let fileUrl: String?
}


extension CoreDataManager {
    func upsertUser(target: UserEntity?, dto: User) {
        if let userId = KeychainWrapper.standard.string(forKey: KeychainWrapper.Key.apiUserId.rawValue),
           let target = target {
            if userId == target.id {
                updateUserData(target: target, dto: dto)
            } // 혹시 안맞으면 지우고 다시 생성??
        } else {
            createNewUser(dto: dto)
        }
    }
    
    func createNewUser(dto: User) {
        mainContext.perform {
            let newUser = UserEntity.init(context: self.mainContext)
            newUser.id = dto.id
            newUser.nickname = dto.nickname
            newUser.relationship = dto.relationship
            newUser.gender = dto.gender
            
            if let fileUrl = dto.fileUrl {
                newUser.fileUrl = fileUrl
            }
            
            self.saveMainContext()
            
            DispatchQueue.global().async {
                if let url = URL(string: dto.fileUrl ?? "") {
                    FileManager.downloadImages(url: url)
                }
            }
            
        }
    }
    
    func fetchUserData() -> [UserEntity] {
        var list: [UserEntity] = [UserEntity]()
        
        mainContext.performAndWait {
            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
    
    func fetchUserData(with userId: String) -> [UserEntity] {
        var list: [UserEntity] = [UserEntity]()
        
        mainContext.performAndWait {
            let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
            let predicate = NSPredicate(format: "id == %@", userId)
            request.predicate = predicate
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
    
    func updateUserData(target: UserEntity, dto: User) {
        mainContext.perform {
            target.id = dto.id
            target.nickname = dto.nickname
            target.relationship = dto.relationship
            target.gender = dto.gender
            target.fileUrl = dto.fileUrl
            
            self.saveMainContext()
            
            DispatchQueue.global().async {
                if let url = URL(string: dto.fileUrl ?? "") {
                    FileManager.downloadImages(url: url)
                }
            }
        }
    }
    
    func deleteUserData(target: UserEntity) {
        mainContext.perform {
            self.mainContext.delete(target)
            
            self.saveMainContext()
        }
    }
    
}

