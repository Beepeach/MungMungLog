//
//  WalkHistoryModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/20.
//

import Foundation

struct WalkHistoryDto: Codable {
    let walkHistoryId: Int
    let startTime: Double
    let endTime: Double
    let distance: Double
    let contents: String?
    let deleted: Bool
    let fileUrl1: String?
    let fileUrl2: String?
    let fileUrl3: String?
    let fileUrl4: String?
    let fileUrl5: String?
    let petId: Int
    let familyMemberId: Int
}

struct WalkHistoryPostModel: Codable {
    let petId: Int
    let familyMemberId: Int
    let startTime: Double
    let endTime: Double
    let distance: Double
    let contents: String?
    let fileUrl1: String?
    let fileUrl2: String?
    let fileUrl3: String?
    let fileUrl4: String?
    let fileUrl5: String?
}

extension CoreDataManager {
    func createNewWalkHistory(dto: WalkHistoryDto) {
        mainContext.perform {
            let newWalkHistory = WalkHistoryEntity.init(context: self.mainContext)
            
            newWalkHistory.distance = dto.distance
            newWalkHistory.startTime = Date(timeIntervalSinceReferenceDate: dto.startTime)
            newWalkHistory.endTime = Date(timeIntervalSinceReferenceDate: dto.endTime)
            newWalkHistory.familyMemberId = Int64(dto.familyMemberId)
            newWalkHistory.petId = Int64(dto.petId)
            newWalkHistory.walkHistoryId = Int64(dto.walkHistoryId)
            newWalkHistory.willBeDeleted = dto.deleted
            
            if let contents = dto.contents {
                newWalkHistory.contents = contents
            }
            
            if let fileUrl1 = dto.fileUrl1 {
                newWalkHistory.fileUrl1 = fileUrl1
            }
            
            if let fileUrl2 = dto.fileUrl2 {
                newWalkHistory.fileUrl2 = fileUrl2
            }
            
            if let fileUrl3 = dto.fileUrl3 {
                newWalkHistory.fileUrl3 = fileUrl3
            }
            
            if let fileUrl4 = dto.fileUrl4 {
                newWalkHistory.fileUrl4 = fileUrl4
            }
            
            if let fileUrl5 = dto.fileUrl5 {
                newWalkHistory.fileUrl5 = fileUrl5
            }

            
            self.saveMainContext()
        }
    }
}
