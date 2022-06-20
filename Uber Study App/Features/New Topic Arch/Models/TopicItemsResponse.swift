//
//  TopicItemsResponse.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

struct TopicItemsResponse: Decodable {
    let topicItems: [TopicItem]
    
    enum TopicResponseItem: Decodable {
        case listItem(ListItem)
        case carouselItem(CarouselItem)
        
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
                case TopicItemType.carouselItem.rawValue:
                    let carouselItem = try CarouselItem(from: decoder)
                    self = .carouselItem(carouselItem)
                default:
                    throw DecodingError.valueNotFound(Self.self, DecodingError.Context.init(codingPath: [], debugDescription: "Topic Item Not Found"))
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case topicItems = "topic_items"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let values = try container.decodeIfPresent([TopicResponseItem].self, forKey: .topicItems) {
            var dataArray = [TopicItem]()
            values.forEach({
                switch $0 {
                    case .listItem(let listItem):
                        dataArray.append(listItem)
                    case .carouselItem(let carouselItem):
                        dataArray.append(carouselItem)
                }
            })
           topicItems = dataArray
           return
        }
        throw DecodingError.valueNotFound(Self.self, DecodingError.Context.init(codingPath: [], debugDescription: "Topic Items not found"))
    }
}
