//
//  ImageViewCollectionViewCell.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import UIKit

class ImageViewCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ImageViewCollectionViewCell"
    static let nib = UINib(nibName: "ImageViewCollectionViewCell", bundle: nil)
    public var viewModel: ImageViewCollectionViewCellViewModel?

    @IBOutlet weak var imageView: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        viewModel?.cancelTask()
    }
}
