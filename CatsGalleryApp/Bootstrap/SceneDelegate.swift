//
//  SceneDelegate.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 09/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            // The view controller and view model can be reused
            // for different terms
            let viewModel = GalleryViewModel(searchTerm: "cats")
            window.rootViewController = GalleryViewController(viewModel: viewModel)

            window.makeKeyAndVisible()
            self.window = window
        }
    }
}

