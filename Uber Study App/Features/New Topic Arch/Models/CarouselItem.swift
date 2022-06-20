//
//  CarouselItem.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

struct CarouselItem: TopicItem {
    var type: TopicItemType
    let title: String
    let listItems: [TopicItem]
    
    enum CarouselListItem: Decodable {
        case listItem(ListItem)
        
        enum CodingKeys: CodingKey {
            case type
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(Int.self, forKey: .type)
            
            switch type {
                case TopicItemType.listItem.rawValue:
                    let listItem = try ListItem(from: decoder)
                    self = .listItem(listItem)
                default:
                    throw DecodingError.valueNotFound(Self.self, DecodingError.Context.init(codingPath: [], debugDescription: "Topic Item Not Found"))
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case type, title, listItems = "list_items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(TopicItemType.self, forKey: .type)
        title = try container.decode(String.self, forKey: .title)
        if let listItems = try container.decodeIfPresent([CarouselListItem].self, forKey: .listItems)
        {
            var dataArray = [TopicItem]()
            listItems.forEach({
                switch $0 {
                    case .listItem(let listItem):
                        dataArray.append(listItem)
                }
            })
            self.listItems = dataArray
            return
        }
        throw DecodingError.valueNotFound(Self.self, DecodingError.Context.init(codingPath: [], debugDescription: "Topic Items not found"))
    }
}
