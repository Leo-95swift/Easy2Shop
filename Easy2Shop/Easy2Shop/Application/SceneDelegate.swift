//
//  SceneDelegate.swift
//  Easy2Shop
//
//  Created by Levon Shaxbazyan on 03.11.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        window?.rootViewController = ProductsViewController()
        window?.rootViewController = BasketViewController()
        window?.makeKeyAndVisible()
    }
}

