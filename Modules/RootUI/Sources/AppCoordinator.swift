//
//  AppCoordinator.swift
//
//  Created by Fernando del Rio on 21/11/19.
//  Copyright © 2019 Fernando del Rio. MIT License.
//

import Combine
import Gallery
import UIKit

public class AppCoordinator {
    private weak var window: UIWindow?
    private var disposeBag = Set<AnyCancellable>()
    private var navigationController: UINavigationController?
    private lazy var galleryCoordinator = GalleryCoordinator(navigationController)

    public init(window: UIWindow) {
        self.window = window
    }

    public func start() {
        showLaunchScreen()

        DispatchQueue.main.async { [weak self] in
            self?.showRootView()
        }
    }

    private func showLaunchScreen() {
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() else {
            fatalError("Could not instantiate initial view controller from storyboard")
        }
        window?.rootViewController = viewController
    }

    private func showRootView() {
        navigationController = UINavigationController(rootViewController: UIViewController())
        navigationController?.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        galleryCoordinator.start(animated: false)
    }
}
