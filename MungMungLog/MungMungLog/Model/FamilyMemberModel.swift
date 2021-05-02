//
//  FamilyMemberModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/14.
//

import Foundation
import CoreData

struct FamilyMemberDto: Codable {
    let familyMemberId: Int
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
            
            newFamilyMember.familyMemberId = Int64(dto.familyMemberId)
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
    
    func fetchFamilyMemberData() -> [FamilyMemberEntity] {
        var list: [FamilyMemberEntity] = []
        
        self.mainContext.performAndWait {
            let request: NSFetchRequest<FamilyMemberEntity> = FamilyMemberEntity.fetchRequest()
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
    
    func fetchFamilyMemeberData(with familyMemeberId: Int) -> [FamilyMemberEntity] {
        var list: [FamilyMemberEntity] = []
        
        self.mainContext.performAndWait {
            let request: NSFetchRequest<FamilyMemberEntity> = FamilyMemberEntity.fetchRequest()
            let predicate = NSPredicate(format: "familyMemberId == %d", familyMemeberId)
            request.predicate = predicate
            request.fetchLimit = 1
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
}

