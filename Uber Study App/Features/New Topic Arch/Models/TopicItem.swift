//
//  TopicItem.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

enum TopicItemType: Int, Decodable {
    case listItem
    case carouselItem
}

protocol TopicItem: Decodable {
    var type: TopicItemType { get }
}

