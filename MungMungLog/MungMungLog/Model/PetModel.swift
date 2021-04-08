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
}

struct PetPostModel: Codable {
    let email: String?
    let name: String?
    let birthday: Double?
    let breed: String?
    let gender: Bool?
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
