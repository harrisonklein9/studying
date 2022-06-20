//
//  ImageLoaderCollectionViewController.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class ImageLoaderCollectionViewController: UIViewController, UICollectionViewDataSource {
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSize(width: view.bounds.width / 3, height: view.bounds.width / 3)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.register(ImageViewCollectionViewCell.nib, forCellWithReuseIdentifier: ImageViewCollectionViewCell.reuseIdentifier)
        
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImageData.imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCollectionViewCell.reuseIdentifier, for: indexPath) as? ImageViewCollectionViewCell else { return UICollectionViewCell() }
        
        let url = ImageData.imageUrls[indexPath.item]
        cell.viewModel = ImageViewCollectionViewCellViewModel(cell: cell, url: url, imageLoader: ImageLoader.shared)
        
        return cell
    }
}
