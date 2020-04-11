//
//  GalleryViewModel.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import Foundation
import Combine

class GalleryViewModel {
    private var searchPublisher: AnyPublisher<[String], Never>?
    private var disposeBag = Set<AnyCancellable>()
    @Published var imageUrls: [String] = []
    @Published var loading: Bool = false

    init(searchTerm: String) {
        let imgurPublisher = ImgurPublisher()
        searchPublisher = imgurPublisher.searchForImage(searchTerm: searchTerm)
    }

    func load() {
        loading = true
        searchPublisher?
            .receive(on: RunLoop.main)
            .sink { [weak self] urls in
                self?.imageUrls = urls
                self?.loading = false
            }
            .store(in: &disposeBag)
    }
}
