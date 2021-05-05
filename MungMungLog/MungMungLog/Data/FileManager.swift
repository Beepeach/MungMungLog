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
    
    static func downloadImages(url: URL) {
        if let fileName = url.absoluteString.components(separatedBy: "/").last {
            if var localUrl = FileManager.cacheDirectoryUrl?.appendingPathComponent(fileName) {
                do {
                    let exist = FileManager.default.fileExists(atPath: localUrl.absoluteString)
                    if !exist {
                        let data = try Data(contentsOf: url)
                        try data.write(to: localUrl)
                        
                        localUrl.excludedFromBackup()
                    }
                } catch {
                    print(error)
                }
            }
        }
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
