//
//  LoginVIewController+KakaoLogin.swift
//  MungMungLog
//
//  Created by JunHeeJo on 12/21/21.
//

import UIKit
import KakaoSDKUser
import SwiftKeychainWrapper

extension LoginViewController {
    func  loginWithKaKaoTalk() {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            
            print("loginWithKakaoTalk Success.")
            self.getUserInfoFromKakao()
        }
    }
    
    func loginWithKakaoAccount() {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            
            print("loginWithKakaoAccount Success.")
            self.getUserInfoFromKakao()
        }
    }
    
    func getUserInfoFromKakao() {
        UserApi.shared.me { (user, error) in
            if let error = error {
                print(error)
            }
            
            guard let id = user?.id else { return }
            
            // TODO: - 카카오 email을 받을수 있을때부터는 UUID로 변경
            let email = user?.kakaoAccount?.email ?? "Test100@test.com" //"\(UUID().uuidString)@empty.com"
            
            self.requestKaKaoLogin(id: id, email: email)
        }
    }
    
    private func requestKaKaoLogin(id: Int64, email: String) {
        let model = SNSLoginRequestModel(provider: "Kakao", id: "\(id)", email: email)
        
        self.login(model: model)
    }
}
