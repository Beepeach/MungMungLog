//
//  UserModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/22.
//

import Foundation
import CoreData

struct User: Codable {
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
    
    
}

