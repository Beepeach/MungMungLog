//
//  LoginViewController+AppleLogin.swift
//  MungMungLog
//
//  Created by JunHeeJo on 12/26/21.
//

import Foundation
import SwiftKeychainWrapper
import AuthenticationServices

// MARK: - ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(#function, "\(error.localizedDescription)")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userId = appleIdCredential.user
            
            // email과 name은 첫번째 이후부터 nil을 주므로 따로 저장하는게 좋지만 name은 사용하지 않으므로 저장하지 않았다.
            var email = appleIdCredential.email
            checkEmailKeychain(email: &email)
            
            let appleLoginModel = SNSLoginRequestModel(provider: "Apple", id: userId, email: email ?? "")
            
            self.login(model: appleLoginModel)
        } else {
            AlertCreator().createOneButtonAlert(vc: self, title: "실패", message: "Apple 인증서 오류", actionTitle: "확인")
        }
    }
    
    private func checkEmailKeychain(email: inout String?) {
        if let savedEmail = KeychainWrapper.standard.string(forKey: .appleUserEmail) {
            email = savedEmail
        } else {
            createEmailKeychain(email: email)
        }
    }
    
    private func createEmailKeychain(email: String?) {
        if let email = email {
            KeychainWrapper.standard.set(email, forKey: KeychainWrapper.Key.appleUserEmail.rawValue)
        }
    }
}

// MARK: - ASAuthorizationControllerPresentationContextProviding
@available(iOS 13.0, *)
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window ?? ASPresentationAnchor()
    }
}
