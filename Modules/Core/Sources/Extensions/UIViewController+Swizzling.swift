//
//  UIViewController+Swizzling.swift
//
//  Created by Fernando del Rio on 21/04/20.
//  Copyright © 2020 Fernando del Rio. MIT License.
//

import UIKit

extension UIViewController {
    public static func setupSwizzling() {
        exchangeViewDidLoad()
    }

    private static func exchangeViewDidLoad() {
        let originalSelector = #selector(Self.viewDidLoad)
        let swizzledSelector = #selector(Self.swz_viewDidLoad)
        if let originalMethod = class_getInstanceMethod(self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc private func swz_viewDidLoad() {
        swz_viewDidLoad()
        if let view = self as? TypeErasedView {
            view.setupBindings()
            view.typeErasedViewModel.load()
        }
    }
}
