//
//  SceneDelegate.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import UIKit

public typealias SceneDelegatable = UIResponder & UIWindowSceneDelegate

public class SceneDelegate: SceneDelegatable {
    private lazy var windowManager = WindowManager()
    private lazy var lifeCycleManager = LifeCycleManager()
    private lazy var sceneDelegates: [SceneDelegatable] = {
        let isUnitTest = NSClassFromString("XCTest") != nil
        return isUnitTest ? [] : [
            windowManager,
            lifeCycleManager
        ]
    }()

    public func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options: UIScene.ConnectionOptions) {
        sceneDelegates.forEach { $0.scene?(scene, willConnectTo: session, options: options) }
    }

    public func sceneDidBecomeActive(_ scene: UIScene) {
        sceneDelegates.forEach { $0.sceneDidBecomeActive?(scene) }
    }

    public func sceneDidEnterBackground(_ scene: UIScene) {
        sceneDelegates.forEach { $0.sceneDidEnterBackground?(scene) }
    }
}
