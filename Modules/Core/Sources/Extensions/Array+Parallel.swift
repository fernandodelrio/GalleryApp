//
//  Array+Parallel.swift
//
//  Created by Fernando del Rio on 16/12/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

// Example:
// let array = (0..<1_000).map { $0 }
// func work(_ n: Int) -> Int {
//     return (0..<n).reduce(0, +)
// }
// array.parallelMap { work($0) }

public extension Array {
    func parallelMap<T>(_ transform: (Element) -> T) -> [T] {
        let result = UnsafeMutablePointer<T>.allocate(capacity: count)

        DispatchQueue.concurrentPerform(iterations: count) { index in
            result[index] = transform(self[index])
        }

        let finalResult: [T] = .init(UnsafeBufferPointer(start: result, count: count))
        result.deallocate()

        return finalResult
    }
}
