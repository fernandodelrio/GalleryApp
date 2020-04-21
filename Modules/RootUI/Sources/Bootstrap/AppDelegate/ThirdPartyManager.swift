//
//  ThirdPartyDelegate.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Core
import UIKit

class ThirdPartyManager: AppDelegatable {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions options: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        oslog(.info, "Setup third party called")
        return true
    }
}
