//
//  CarouselCollectionViewDelegateFlowLayout.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import UIKit

class CarouselCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private let data: [TopicItem]
    
    init(data: [TopicItem]) {
        self.data = data
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = data[indexPath.item]
        switch item.type {
            case .listItem:
                var width = UIScreen.main.bounds.width / 2
                if UIDevice.current.userInterfaceIdiom == .pad {
                    width = UIScreen.main.bounds.width / 5
                }
                let height = (width * 2 / 3) + 50
                return CGSize(width: width, height: height)
            default:
                return .zero
        }
    }
}
