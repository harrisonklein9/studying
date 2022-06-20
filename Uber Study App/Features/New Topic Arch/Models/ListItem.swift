//
//  ListItem.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

struct ListItem: TopicItem {
    var type: TopicItemType = .listItem
    let title: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case type, title, imageUrl = "image_url"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(TopicItemType.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
}
