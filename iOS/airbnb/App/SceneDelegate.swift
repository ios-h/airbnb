//
//  SceneDelegate.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainTabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
    }
}
