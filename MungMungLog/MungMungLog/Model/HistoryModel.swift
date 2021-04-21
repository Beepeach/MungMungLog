//
//  HistoryModel.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/20.
//

import Foundation

struct HistoryDto: Codable {
    let historyId: Int
    let type: Int
    let date: Double
    let contents: String
    let deleted: Bool
    let fileUrl1: String?
    let fileUrl2: String?
    let fileUrl3: String?
    let fileUrl4: String?
    let fileUrl5: String?
    let petId: Int
    let familyMemberId: Int
}
