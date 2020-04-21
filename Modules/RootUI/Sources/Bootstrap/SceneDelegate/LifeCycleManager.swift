//
//  LifeCycleManager.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Core
import UIKit

class LifeCycleManager: SceneDelegatable {
    func sceneDidBecomeActive(_ scene: UIScene) {
        oslog(.info, "Scene Did Become Active")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        oslog(.info, "Scene Did Enter Background")
    }
}
