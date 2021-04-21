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
