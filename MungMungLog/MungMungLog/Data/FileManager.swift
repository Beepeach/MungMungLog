//
//  FileManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/05/02.
//

import Foundation

extension FileManager {
    static var cacheDirectoryUrl: URL? {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        
        return urls.last
    }
}

extension URL {
    mutating func excludedFromBackup() {
        do {
            let exist = try checkResourceIsReachable()
            if exist {
                var resourceValues = URLResourceValues()
                resourceValues.isExcludedFromBackup = true
                
                try setResourceValues(resourceValues)
            }
        } catch {
            print(error)
        }
    }
}
