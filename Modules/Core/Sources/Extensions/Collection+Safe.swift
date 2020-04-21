//
//  Collection+Safe.swift
//
//  Created by Fernando del Rio on 16/12/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

// Example:
// let data = [1, 3, 4]
// data[safe: 1] // Optional(3)
// data[safe: 10] // nil

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
