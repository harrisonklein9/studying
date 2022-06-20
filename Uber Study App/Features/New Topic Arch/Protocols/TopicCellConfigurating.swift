//
//  TopicCellConfigurating.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

protocol TopicCellConfigurating {
    static var reuseId: String { get }
    static var nib: UINib { get }
    func configure(cell: UICollectionViewCell)
}

class TopicCellConfigurator<CellType: TopicCell, DataItem>: TopicCellConfigurating where CellType.DataItem == DataItem, CellType: UICollectionViewCell {
    
    let item: DataItem
    
    init(item: DataItem) {
        self.item = item
    }
    
    static var reuseId: String { return String(describing: CellType.self) }
    static var nib: UINib { return UINib(nibName: String(describing: CellType.self), bundle: nil)}
    
    func configure(cell: UICollectionViewCell) {
        guard let cell = cell as? CellType else { return }
        cell.configure(item)
    }
}
