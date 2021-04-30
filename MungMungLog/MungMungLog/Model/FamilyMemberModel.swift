//
//  FamilyMemberModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/14.
//

import Foundation

struct FamilyMemberDto: Codable {
    let isMaster: Bool
    let status: Int
    let userId: String
    let familyId: Int?
    let histories: [HistoryDto]?
    let walkHistories: [WalkHistoryDto]?
}


extension CoreDataManager {
    func createNewFamilyMember(dto: FamilyMemberDto) {
        mainContext.perform {
            let newFamilyMember = FamilyMemberEntity.init(context: self.mainContext)
            
            newFamilyMember.userId = dto.userId
            newFamilyMember.status = Int16(dto.status)
            newFamilyMember.isMaster = dto.isMaster
            
            if let histories = dto.histories {
                histories.forEach {
                    CoreDataManager.shared.createNewHistory(dto: $0)
                }
            }
            
            if let walkHistories = dto.walkHistories {
                walkHistories.forEach {
                    CoreDataManager.shared.createNewWalkHistory(dto: $0)
                }
                // newFamilyMember.walkHistories = NSSet(array: walkHistories)
            }
            
            self.saveMainContext()
           
        }
    }
}

