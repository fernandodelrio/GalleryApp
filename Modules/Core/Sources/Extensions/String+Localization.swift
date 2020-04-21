//
//  String+Localization.swift
//
//  Created by Fernando del Rio on 03/11/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
