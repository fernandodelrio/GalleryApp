//
//  UIImageView+AsyncLoad.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit
import Combine

fileprivate var imageCache = NSCache<NSString, UIImage>()
fileprivate var disposeBag = Set<AnyCancellable>()

extension UIImageView {
    func loadUrl(_ url: String) {
        // If it's already in cache returns it
        if let cached = imageCache.object(forKey: url as NSString) {
            image = cached
            return
        }
        // Otherwise, download and save on cache
        showLoading()
        URL(string: url)
            .map { URLSession.shared.dataTaskPublisher(for: $0) }?
            .map { $0.data }
            .map { UIImage(data: $0) }
            .catch { error -> Just<UIImage?> in
                Just(UIImage(named: "404"))
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] image in
                image.map { imageCache.setObject($0, forKey: url as NSString) }
                self?.image = image
                self?.hideLoading()
            }.store(in: &disposeBag)
    }
}
