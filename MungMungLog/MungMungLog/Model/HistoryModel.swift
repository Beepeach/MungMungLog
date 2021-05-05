//
//  HistoryModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/20.
//

import Foundation
import CoreData

struct HistoryDto: Codable {
    let historyId: Int
    let type: Int
    let date: Double
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

extension CoreDataManager {
    func createNewHistory(dto: HistoryDto) {
        mainContext.perform {
            let newHistory = HistoryEntity.init(context: self.mainContext)
        
            newHistory.date = Date(timeIntervalSinceReferenceDate: dto.date)
            newHistory.familyMemberId = Int64(dto.familyMemberId)
            newHistory.historyId = Int64(dto.historyId)
            newHistory.petId = Int64(dto.petId)
            newHistory.type = Int16(dto.type)
            newHistory.willBeDeleted = dto.deleted
            
            if let contents = dto.contents {
                newHistory.contents = contents
            }
            
            if let fileUrl1 = dto.fileUrl1 {
                newHistory.fileUrl1 = fileUrl1
            }
            
            if let fileUrl2 = dto.fileUrl2 {
                newHistory.fileUrl2 = fileUrl2
            }
            
            if let fileUrl3 = dto.fileUrl3 {
                newHistory.fileUrl3 = fileUrl3
            }
            
            if let fileUrl4 = dto.fileUrl4 {
                newHistory.fileUrl4 = fileUrl4
            }
            
            if let fileUrl5 = dto.fileUrl5 {
                newHistory.fileUrl5 = fileUrl5
            }

            self.saveMainContext()
        }
    }
    
    func fetchLatestHistoryData() -> [HistoryEntity] {
        var list: [HistoryEntity] = []
        
        mainContext.performAndWait {
            let request: NSFetchRequest<HistoryEntity> = HistoryEntity.fetchRequest()
            let sortByDateDESC: NSSortDescriptor = NSSortDescriptor(key: #keyPath(HistoryEntity.date), ascending: false)
            request.sortDescriptors = [sortByDateDESC]
            request.fetchOffset = 1
            
            do {
                list = try mainContext.fetch(request)
            } catch {
                print(error)
            }
        }
        
        return list
    }
}
