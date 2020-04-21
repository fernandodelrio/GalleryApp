//
//  AppDelegate.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import UIKit

typealias AppDelegatable = UIResponder & UIApplicationDelegate

@UIApplicationMain
class AppDelegate: AppDelegatable {
    private lazy var sceneConfigManager = SceneConfigurationManager()
    private lazy var thirdPartyManager = ThirdPartyManager()
    private lazy var appearanceManager = AppearanceManager()
    private lazy var appDelegates: [AppDelegatable] = {
        let isUnitTest = NSClassFromString("XCTest") != nil
        return isUnitTest ? [] : [
            sceneConfigManager,
            thirdPartyManager,
            appearanceManager
        ]
    }()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return appDelegates
            .compactMap { $0.application?(application, didFinishLaunchingWithOptions: options) }
            .allSatisfy { $0 }
    }

    func application(
        _ application: UIApplication,
        configurationForConnecting session: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfigurations = appDelegates.compactMap {
            $0.application?(
                application,
                configurationForConnecting: session,
                options: options
            )
        }
        return sceneConfigurations.first ?? UISceneConfiguration()
    }
}
