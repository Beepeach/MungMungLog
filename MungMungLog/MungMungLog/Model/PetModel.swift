//
//  PetModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/09.
//

import Foundation

struct PetDto: Codable {
    let petId: Int
    let name: String
    let birthday: Double
    let breed: String
    let gender: Bool
    var fileUrl: String? = nil
    let familyId: Int
    let histories: [HistoryDto]?
    let walkHistories: [WalkHistoryDto]?
}

struct PetPostModel: Codable {
    let email: String
    let name: String
    let birthday: Double
    let breed: String
    let gender: Bool
    let fileUrl: String?
}

struct PetPutModel: Codable {
    let email: String
    let name: String
    let birthday: Double
    let breed: String
    let gender: Bool
    let fileUrl: String?
}


extension CoreDataManager {
    func createNewPet(dto: PetDto) {
        mainContext.perform {
            let newPet = PetEntity(context: self.mainContext)
            
            newPet.petId = Int64(dto.petId)
            newPet.name = dto.name
            newPet.birthday = Date(timeIntervalSinceReferenceDate: dto.birthday)
            newPet.breed = dto.breed
            newPet.gender = dto.gender
            newPet.fileUrl = dto.fileUrl
            
            self.saveMainContext()
            
            DispatchQueue.global().async {
                if let url = URL(string: dto.fileUrl ?? "") {
                    FileManager.downloadImages(url: url)
                }
                
            }
        }
    }
    
    func updatePet(target: PetEntity, dto: PetDto) {
        mainContext.perform {
            target.name = dto.name
            target.birthday = Date(timeIntervalSinceReferenceDate: dto.birthday)
            target.breed = dto.breed
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
}
