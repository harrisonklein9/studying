//
//  CarouselItemCollectionViewCell.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

typealias CarouselItemCellConfigurator = TopicCellConfigurator<CarouselItemCollectionViewCell, CarouselItem>

class CarouselItemCollectionViewCell: UICollectionViewCell, TopicCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    typealias DataItem = CarouselItem
    
    private var items = [TopicItem]()
    
    private lazy var dataSource: TopicCollectionViewDataSource = {
        return TopicCollectionViewDataSource(data: items)
    }()
    
    private lazy var delegate: CarouselCollectionViewDelegateFlowLayout = {
        return CarouselCollectionViewDelegateFlowLayout(data: items)
    }()
    
    func configure(_ data: CarouselItem) {
        collectionView.register(ListItemCellConfigurator.nib, forCellWithReuseIdentifier: ListItemCellConfigurator.reuseId)
        items = data.listItems
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
    }
}
