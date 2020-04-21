//
//  Log.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import os

public enum LogType {
    case configuration
    case info

    var logType: (OSLogType, OSLog) {
        switch self {
        case .configuration: return (.error, .configuration)
        case .info: return (.error, .info)
        }
    }
}

public func oslog(_ type: LogType, _ message: StaticString, _ args: CVarArg...) {
    os_log(type.logType.0, log: type.logType.1, message, args)
}

public func oslog(_ type: LogType, _ message: StaticString) {
    os_log(type.logType.0, log: type.logType.1, message)
}
