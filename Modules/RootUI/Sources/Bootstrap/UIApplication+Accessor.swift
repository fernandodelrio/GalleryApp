//
//  UIApplication+Accessor.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Core
import UIKit

extension UIApplication {
    static var appDelegate: AppDelegate {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            oslog(.configuration, "App Delegate not set")
            fatalError()
        }
        return delegate
    }

    static var sceneDelegate: SceneDelegate {
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            oslog(.configuration, "Scene Delegate not set")
            fatalError()
        }
        return delegate
    }
}
