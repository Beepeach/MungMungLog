//
//  BlobManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/15.
//

import Foundation
import AZSClient

struct BlobManager {
    static let shared = BlobManager()
    
    private let account: AZSCloudStorageAccount?
    private let client: AZSCloudBlobClient?
    private let container: AZSCloudBlobContainer?
    
    private init() {
        account = try? AZSCloudStorageAccount(fromConnectionString: aZSCloudStorageAccountKey)
        client = account?.getBlobClient()
        container = client?.containerReference(fromName: "main")
    }
    
    func upload(image: UIImage, completion: @escaping (String?) -> ()) {
        guard let data = image.pngData() else {
            completion(nil)
            return
        }
        
        let uuid = UUID().uuidString + ".png"
        
        let blob = container?.blockBlobReference(fromName: uuid)
        blob?.upload(from: data, completionHandler: { (error) in
            if let _ = error {
                completion(nil)
                return
            }
            
            completion(container?.storageUri.primaryUri.appendingPathComponent(uuid).absoluteString)
        })
    }
}
