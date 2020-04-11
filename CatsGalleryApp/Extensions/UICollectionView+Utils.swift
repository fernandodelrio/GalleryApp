//
//  UICollectionView+Utils.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ type: T.Type) {
        let nib = UINib(nibName: String(describing: type), bundle: nil)
        register(nib, forCellWithReuseIdentifier:String(describing: type))
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(
            withReuseIdentifier: String(describing: type),
            for: indexPath
        ) as? T ?? T()
        return cell
    }
}
