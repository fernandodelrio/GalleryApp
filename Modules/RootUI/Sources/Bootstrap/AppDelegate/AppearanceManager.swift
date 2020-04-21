//
//  AppearanceManager.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Core
import UIKit

class AppearanceManager: AppDelegatable {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        oslog(.info, "Setup appearance called")
        return true
    }
}
