//
//  SceneDelegate.swift
//  airbnb
//
//  Created by 안상희 on 2022/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        coordinator = AppCoordinator(window: window)
        coordinator?.start()
    }
}
