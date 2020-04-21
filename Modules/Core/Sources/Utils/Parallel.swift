//
//  Parallel.swift
//
//  Created by Fernando del Rio on 16/12/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

// Example:
// let values = (1...100_000).map { $0 }
// let results = parallel(values.map { $0 * $0 }, values.reduce(0, +))

public func parallel<T, U>(_ left: @autoclosure () -> T, _ right: @autoclosure () -> U) -> (T, U) {
    var leftRes: T?
    var rightRes: U?

    DispatchQueue.concurrentPerform(iterations: 2) { index in
        if index == 0 {
            leftRes = left()
        } else {
            rightRes = right()
        }
    }

    if let leftResult = leftRes, let rightResult = rightRes {
        return (leftResult, rightResult)
    } else {
        fatalError("Unable to get the results")
    }
}
