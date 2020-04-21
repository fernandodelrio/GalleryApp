//
//  String+Ranges.swift
//
//  Created by Fernando del Rio on 16/12/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Foundation

// Example:
// let data = "This is a string!"
// data[..<4]  // "This"
// data[5..<9] // "is a"
// data[10...] // "string!"

public extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: value.lowerBound)...index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: CountableRange<Int>) -> Substring {
        return self[index(startIndex, offsetBy: value.lowerBound)..<index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        return self[..<index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring {
        return self[...index(startIndex, offsetBy: value.upperBound)]
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring {
        return self[index(startIndex, offsetBy: value.lowerBound)...]
    }
}
