//
//  ImgurPublisher.swift
//  CatsGalleryApp
//
//  Created by Fernando del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import Combine
import Core
import Foundation

public class ImgurPublisher {
    public init() {
    }

    public func searchForImage(searchTerm: String) -> AnyPublisher<[String], Never>? {
        // Read endpoint details from plist
        let imgurPlist = Bundle.main.path(forResource: "Info", ofType: "plist")
            .map { NSDictionary(contentsOfFile: $0) ?? [:] }
        let endpoint = imgurPlist?["Search Endpoint"] as? String ?? ""
        let method = imgurPlist?["Search HTTP Method"] as? String ?? ""
        let authorization = imgurPlist?["Search Authorization"] as? String ?? ""

        // Create request
        var request = URL(string: "\(endpoint)?q=\(searchTerm)")
            .map { URLRequest(url: $0) }
        request?.httpMethod = method
        request?.addValue(authorization, forHTTPHeaderField: "Authorization")

        // Gets the response, parse into urls and returns the publishers
        return request
            .map { URLSession.shared.dataTaskPublisher(for: $0) }?
            .map { $0.data }
            .decode(type: GallerySearch.self, decoder: JSONDecoder())
            .map { $0.urls }
            .catch { _ -> Just<[String]> in
                Just(["404"])
            }
            .eraseToAnyPublisher()
    }
}
