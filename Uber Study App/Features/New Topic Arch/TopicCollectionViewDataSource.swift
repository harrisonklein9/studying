//
//  TopicListCollectionViewDataSource.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

class TopicCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    private var dataSource: [TopicCellConfigurating]
    
    init(data: [TopicItem]) {
        self.dataSource = Self.setupDataSource(data)
        super.init()
    }
    
    static private func setupDataSource(_ data: [TopicItem]) -> [TopicCellConfigurating] {
        var dataSource = [TopicCellConfigurating]()
        for item in data {
            switch item.type {
                case .listItem:
                    dataSource.append(ListItemCellConfigurator(item: item as! ListItem))
                case .carouselItem:
                    dataSource.append(CarouselItemCellConfigurator(item: item as! CarouselItem))
            }
        }
        return dataSource
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = dataSource[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: item).reuseId, for: indexPath)
        item.configure(cell: cell)
        
        return cell
    }
}
