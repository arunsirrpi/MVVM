//
//  SceneDelegate.swift
//  MVVM
//
//  Created by Arun Sinthanaisirrpi on 17/7/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var homeViewController: BookSearchHomeViewController? = nil

    func scene(_ scene: UIScene,
               willConnectTo session:
               UISceneSession, options connectionOptions:
               UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        homeViewController = BookSearchHomeViewController(nibName: nil, bundle: nil)
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
    }

}

