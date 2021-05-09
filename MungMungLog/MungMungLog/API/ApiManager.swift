//
//  ApiManager.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2021/04/03.
//

import Foundation
import SwiftKeychainWrapper

enum ApiError: Error {
    case invalidURL
    case failed(Int)
    case emptyData
}

class ApiManager {
    static let shared = ApiManager()
    private init() {}
    
    enum Path: String {
        case emailLogin = "/api/login/email"
        case snsLogin = "/api/login/sns"
        case emailJoin = "/api/join/email"
        case joinWithInfo = "/api/join/info"
        case createPet = "/api/pet"
        case getPetList = "/api/pet/list"
        case requestInvitation = "/api/family/invitation"
        case getUser = "/api/user"
        case getFamilyMemebers = "/api/familyMember"
    }
    
    static var emailLogin: String {
        return "\(host)\(Path.emailLogin.rawValue)"
    }
    
    static var snsLogin: String {
        return "\(host)\(Path.snsLogin.rawValue)"
    }
    
    static var emailJoin: String {
        return "\(host)\(Path.emailJoin.rawValue)"
    }
    
    static var joinWithInfo: String {
        return "\(host)\(Path.joinWithInfo.rawValue)"
    }
    
    static var createPet: String {
        return "\(host)\(Path.createPet.rawValue)"
    }
    
    static var getPetList: String {
        let familyId = KeychainWrapper.standard.integer(forKey: .apiFamilyId) ?? -1
        
        return "\(host)\(Path.getPetList.rawValue)" + "/\(familyId)"
    }
    
    static var requestInvitation: String {
        return "\(host)\(Path.requestInvitation.rawValue)"
    }
    
    static var getUser: String {
        
        return "\(host)\(Path.getUser.rawValue)"
    }
    
    static var getFamilyMembers: String {
        
        
        return "\(host)\(Path.getFamilyMemebers.rawValue)"
    }
    
    
     func fetch<T: Codable> (urlStr: String, httpMethod: String = "Get", body: Data? = nil, completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: urlStr) else {
            DispatchQueue.main.async {
                completion(.failure(ApiError.invalidURL))
            }
            return
        }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        if let body = body {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }
        
        if let token = KeychainWrapper.standard.string(forKey: .apiToken) {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.failed((response as? HTTPURLResponse)?.statusCode ?? -1)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.emptyData))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(responseData))
                }
                
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
        
        task.resume()
     }
}
