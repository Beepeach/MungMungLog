//
//  NotificationName.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/14.
//

import Foundation

// App이 foreground, background로 진입할때 사용
extension Notification.Name {
    static let sceneWillEnterForeground = Notification.Name("sceneWillEnterForeground")
    
    static let sceneDidEnterBackground = Notification.Name("sceneDidEnterBackground")
}

//
extension Notification.Name {
    static let willEndRecodingWalkRecord = Notification.Name("willEndRecodingWalkRecord")
}

// 기록상세 화면에서 이미지를 선택하고 확인을 누를때
extension Notification.Name {
    static let didSelectHistoryImage = Self("didSelectHistoryImage")
}
