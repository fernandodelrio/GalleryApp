//
//  TimeInterval+WaitTimes.swift
//
//  Created by Fernando del Rio on 20/11/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

public extension TimeInterval {
    static var shortTimeout: TimeInterval {
        return 0.5
    }

    static var defaultTimeout: TimeInterval {
        return 1.0
    }

    static var mediumTimeout: TimeInterval {
        return 3.0
    }

    static var longTimeout: TimeInterval {
        return 10.0
    }
}
