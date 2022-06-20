//
//  TopicCell.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

protocol TopicCell {
    associatedtype DataItem: TopicItem
    func configure(_ data: DataItem)
}
