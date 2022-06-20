//
//  ListItemCollectionViewCell.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

typealias ListItemCellConfigurator = TopicCellConfigurator<ListItemCollectionViewCell, ListItem>

class ListItemCollectionViewCell: UICollectionViewCell, TopicCell {
    typealias DataItem = ListItem
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 5.0
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .gray
    }
    
    func configure(_ data: ListItem) {
        titleLabel.text = data.title
        guard let imageUrl = URL(string: data.imageUrl) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            _ = ImageLoader.shared.image(for: imageUrl) { result in
                switch result {
                    case .success(let image):
                        DispatchQueue.main.async { [weak self] in
                            self?.imageView.image = image
                        }
                    default:
                        break
                }
            }
        }
    }
}
