//
//  SceneDelegate.swift
//  MungMungLog
//
//  Created by JunHee Jo on 2020/11/08.
//

import UIKit
import KakaoSDKAuth

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // KaKaoLogin
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let sceneEnterBackgroundTime = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else {
            return
        }
        
        let elaspedTime: Double = Date().timeIntervalSince(sceneEnterBackgroundTime)
        
        NotificationCenter.default.post(name: .sceneWillEnterForeground, object: nil, userInfo: ["elaspedTime": elaspedTime])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: .sceneDidEnterBackground, object: nil)
        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    }
}

