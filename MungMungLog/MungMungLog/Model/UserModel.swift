//
//  UserModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/22.
//

import Foundation
import CoreData

struct User: Codable {
    let id: String
    let nickname: String
    let relationship: String
    let gender: Bool
    let fileUrl: String?
    let familyId: Int?
    let family: Family?
}


extension CoreDataManager {
    func createNewUser(dto: User) {
        mainContext.perform {
            let newUser = UserEntity.init(context: self.mainContext)
            newUser.nickname = dto.nickname
            newUser.relationship = dto.relationship
            newUser.gender = dto.gender
            newUser.fileUrl = dto.fileUrl
            
            if let familyId = dto.familyId {
                newUser.familyId = Int64(familyId)
            }
            
            self.saveMainContext()
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
    
    func updateUserData(target: UserEntity, dto: User) {
        mainContext.perform {
            target.nickname = dto.nickname
            target.relationship = dto.relationship
            target.gender = dto.gender
            target.fileUrl = dto.fileUrl
            
            if let familyId = dto.familyId {
                target.familyId = Int64(familyId)
            }
            
            self.saveMainContext()
        }
    }
    
    func deleteUserData(target: UserEntity) {
        mainContext.perform {
            self.mainContext.delete(target)
            
            self.saveMainContext()
        }
    }
    
}

