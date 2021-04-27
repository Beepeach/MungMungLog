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
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

