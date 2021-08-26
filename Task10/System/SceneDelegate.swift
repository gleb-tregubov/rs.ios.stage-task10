//
//  SceneDelegate.swift
//  Task10
//
//  Created by Gleb Tregubov on 25.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        
        let navigationViewController = NavigationViewController(rootViewController: NewGameViewController())
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        
    }
}

