//
//  UIView+Loading.swift
//  CatsGalleryApp
//
//  Created by Fernando del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit

public extension UIView {
    func showLoading() {
        hideLoading()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let centerXConstraint = activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerYConstraint = activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)

        addSubview(activityIndicator)
        addConstraints([centerXConstraint, centerYConstraint])
    }

    func hideLoading() {
        subviews
            .compactMap { $0 as? UIActivityIndicatorView }
            .forEach { $0.removeFromSuperview() }
    }
}
