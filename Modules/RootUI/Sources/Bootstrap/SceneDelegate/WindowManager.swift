//
//  WindowManager.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Core
import UIKit

class WindowManager: SceneDelegatable {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options: UIScene.ConnectionOptions) {
        UIViewController.setupSwizzling()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            coordinator = AppCoordinator(window: window)
            coordinator?.start()
            window.makeKeyAndVisible()
            self.window = window
        }
    }
}
