//
//  NewTopicArchDataSource.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/19/22.
//

import Foundation

struct NewTopicArchDataSource {
    
    static let data: TopicItemsResponse? = {
        let jsonDecoder = JSONDecoder()
        
        if let path = Bundle.main.url(forResource: "Topics", withExtension: "json"),
           let jsonData = try? String(contentsOf: path).data(using: .utf8),
           let items = try? jsonDecoder.decode(TopicItemsResponse.self, from: jsonData) {
            return items
        }
        
        return nil
    }()
    
    
}
