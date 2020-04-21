//
//  GalleryViewController.swift
//  CatsGalleryApp
//
//  Created by Fernando del Rio on 09/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import Combine
import Core
import Network
import UIKit

class GalleryViewController: UIViewController, View {
    private let collectionViewGridPadding: CGFloat = 16
    private let collectionViewGridCells: (onPortrait: CGFloat, onLandscape: CGFloat) = (2, 3)
    private var disposeBag = Set<AnyCancellable>()
    internal let viewModel: GalleryViewModel

    @IBOutlet private weak var collectionView: UICollectionView?

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(viewModel: GalleryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(GalleryViewCell.self)
    }

    func setupBindings() {
        viewModel
            .$imageUrls
            .sink { [weak self] _ in
                // When there's new data, reloads the collection view
                self?.collectionView?.reloadData()
            }
            .store(in: &disposeBag)
        viewModel
            .$loading
            .sink { [weak self] loading in
                // Show / Hide the loading based on the view model
                loading ? self?.view.showLoading() : self?.view.hideLoading()
            }
            .store(in: &disposeBag)
    }
}

// MARK: - UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(GalleryViewCell.self, for: indexPath)
        // Asynchronously loads the images, for a better performance on mobile
        cell.imageView?.loadUrl(viewModel.imageUrls[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculates the cell size based on the current screen
        // and the grid settings
        let cellsOnPortrait = collectionViewGridCells.onPortrait
        let cellsOnLandscape = collectionViewGridCells.onLandscape
        let cellsPerRow: CGFloat = traitCollection.verticalSizeClass == .compact ? cellsOnLandscape : cellsOnPortrait
        let width = collectionView.bounds.width - (cellsPerRow - 1) * collectionViewGridPadding
        let side = width / cellsPerRow
        return CGSize(width: side, height: side)
    }
}
