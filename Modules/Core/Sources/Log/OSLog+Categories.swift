//
//  OSLog+Categories.swift
//
//  Created by Fernando del Rio on 30/10/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import os

public extension OSLog {
    static var configuration: OSLog {
        return OSLog(subsystem: "br.com.fernandodelrio.GalleryApp", category: "configuration")
    }

    static var info: OSLog {
        return OSLog(subsystem: "br.com.fernandodelrio.GalleryApp", category: "information")
    }
}
