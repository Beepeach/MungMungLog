//
//  LoginViewController+SNSLogin.swift
//  MungMungLog
//
//  Created by JunHeeJo on 12/21/21.
//

import UIKit
import SwiftKeychainWrapper

extension LoginViewController {
    // TODO: - 이걸 그대로 emailLogin에서 이용할 방법은?? Codable로 하면 encode가 안된다.
    func login(model: SNSLoginRequestModel) {
        KeychainWrapper.standard.remove(forKey: .apiToken)
        
        var data: Data? = nil
        let encoder = JSONEncoder()
        
        do {
            data = try encoder.encode(model)
        } catch {
            print(error)
        }
        
        ApiManager.shared.fetch(urlStr: ApiManager.snsLogin, httpMethod: "Post", body: data) { (result: Result<LoginResponseModel, Error>) in
            switch result {
            case .success(let responseData):
                if responseData.code == Statuscode.ok.rawValue {
                    self.saveUserDataInKeychainAndCoreData(with: responseData)
                    
                    print("=======로그인 성공========")
                    print(#function, responseData)
                    
                    self.goToCorrectSceneForKeychain()
                    
                } else {
                    print("========로그인실패===========")
                    print(#function, responseData)
                    
                    DispatchQueue.main.async {
                        self.presentOneButtonAlert(alertTitle: "알림", message: "SNS 로그인에 실패했습니다.", actionTitle: "확인")
                    }
                }
            case .failure(let error):
                print(error)
                
                DispatchQueue.main.async {
                    self.presentOneButtonAlert(alertTitle: "알림", message: "SNS 로그인에 실패했습니다.", actionTitle: "확인")
                }
            }
            
        }
    }
}
