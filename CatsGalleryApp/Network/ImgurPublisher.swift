//
//  ImgurPublisher.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import Foundation
import Combine

class ImgurPublisher {
    func searchForImage(searchTerm: String) -> AnyPublisher<[String], Never>? {
        // Read endpoint details from plist
        let decoder = PropertyListDecoder()
        let imgurPlist = try? Bundle.main.url(forResource: "Imgur", withExtension: "plist")
            .map { try Data(contentsOf: $0) }
            .map { try decoder.decode(Dictionary<String, String>.self, from: $0) }
        let endpoint = imgurPlist?["Search Endpoint"] ?? ""
        let method = imgurPlist?["Search HTTP Method"] ?? ""
        let authorization = imgurPlist?["Search Authorization"] ?? ""

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
            .catch { error -> Just<[String]> in
                Just(["404"])
            }
            .eraseToAnyPublisher()
    }
}
