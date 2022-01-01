//
//  AppDelegate.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/08.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDKCommon.initSDK(appKey: "c21b7a3b3d287e24904b0f47c9c233f5")
        
        checkIsFirstlaunch()
        
        CoreDataManager.shared.setup(modelName: "MungMungLog")
        
        return true
    }
    
    func checkIsFirstlaunch() {
        if !UserDefaults.standard.bool(forKey: UserDefaultKeys.isSecondLaunch.rawValue) {
            deleteKeychainInfo()
            
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.isSecondLaunch.rawValue)
        } else {
            print("첫 실행이 아닙니다.")
        }
    }
    
    // Kakao login
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
         if (AuthApi.isKakaoTalkLoginUrl(url)) {
             return AuthController.handleOpenUrl(url: url)
         }

         return false
     }
    
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

