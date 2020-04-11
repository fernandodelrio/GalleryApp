//
//  GalleryViewController.swift
//  CatsGalleryApp
//
//  Created by Fernando Henrique Bonfim Moreno Del Rio on 09/04/20.
//  Copyright © 2020 Fernando del Rio. All rights reserved.
//

import UIKit
import Combine

class GalleryViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView?
    private let collectionViewGridPadding: CGFloat = 16
    private let collectionViewGridCells: (onPortrait: CGFloat, onLandscape: CGFloat) = (2, 3)
    private var disposeBag = Set<AnyCancellable>()
    private let viewModel: GalleryViewModel

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

        // Setup collection view
        collectionView?.register(GalleryViewCell.self)

        // Setup the bindings
        setupBindings()

        // Starts the process. Loads the data
        viewModel.load()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        // Reloads the colllection view when rotating the screen
        collectionView?.reloadData()
    }

    private func setupBindings() {
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

// MARK: - UICollectionViewDataSource

extension GalleryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculates the cell size based on the current screen
        // and the grid settings
        let cellsOnPortrait = collectionViewGridCells.onPortrait
        let cellsOnLandscape = collectionViewGridCells.onLandscape
        let cellsPerRow: CGFloat = traitCollection.verticalSizeClass == .compact ? cellsOnLandscape : cellsOnPortrait
        let width = collectionView.bounds.width - (cellsPerRow-1) * collectionViewGridPadding
        let side = width / cellsPerRow
        return CGSize(width: side, height: side)
    }
}
