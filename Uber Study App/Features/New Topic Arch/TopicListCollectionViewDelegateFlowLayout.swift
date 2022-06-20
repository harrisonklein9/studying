//
//  TopicListCollectionViewDelegateFlowLayout.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

class TopicListCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let data: [TopicItem]
    
    init(data: [TopicItem]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = data[indexPath.item]
        switch item.type {
            case .listItem:
                var width = UIScreen.main.bounds.width - 40
                if UIDevice.current.userInterfaceIdiom == .pad {
                    width = width / 3 - 20
                }
                let height = (width * 2 / 3) + 50
                return CGSize(width: width, height: height)
            case .carouselItem:
                var cellWidth = UIScreen.main.bounds.width / 2
                if UIDevice.current.userInterfaceIdiom == .pad {
                    cellWidth = UIScreen.main.bounds.width / 5
                }
                let height = (cellWidth * 2 / 3) + 70
                return CGSize(width: UIScreen.main.bounds.width - 20, height: height)
        }
    }
    
}
