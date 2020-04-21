//
//  GalleryViewCell.swift
//  CatsGalleryApp
//
//  Created by Fernando del Rio on 10/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit

class GalleryViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 10.0
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
}
