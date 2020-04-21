//
//  GalleryCoordinator.swift
//
//  Created by Fernando del Rio on 27/11/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Combine
import UIKit

public class GalleryCoordinator {
    private var disposeBag = Set<AnyCancellable>()
    private weak var navigationController: UINavigationController?

    public init(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    public func start(animated: Bool = true) {
        let viewModel = GalleryViewModel(searchTerm: "cats")
        let viewController = GalleryViewController(viewModel: viewModel)

        navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }
}
