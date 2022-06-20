//
//  ImageViewCollectionViewCellViewModel.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import Foundation

class ImageViewCollectionViewCellViewModel {

    private let url: URL
    private let imageLoader: ImageLoader
    private var currentRequestId: UUID?
    private weak var cell: ImageViewCollectionViewCell?
    
    init(cell: ImageViewCollectionViewCell, url: URL, imageLoader: ImageLoader) {
        self.cell = cell
        self.url = url
        self.imageLoader = imageLoader
        currentRequestId = imageLoader.image(for: url) { result in
            switch result {
                case .success(let image):
                    DispatchQueue.main.async { [weak self] in
                        self?.cell?.imageView.image = image
                        self?.currentRequestId = nil
                    }
                default:
                    break
            }
        }
    }
    
    public func cancelTask() {
        if let currentRequestId = currentRequestId {
            imageLoader.cancelTask(with: currentRequestId)
        }
    }
    
}
