//
//  LRUCache.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import Foundation

class LRUCache<Key: Hashable, Value: AnyObject> {
    
    private let cacheSize: Int
    private var lruArray = [Key]()
    private var cache = [Key: Value]()
    private let concurrentQueue = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)
    
    init(cacheSize: Int) {
        self.cacheSize = cacheSize
    }
    
    public func addObject(_ value: Value, for key: Key) {
        concurrentQueue.async { [weak self] in
            guard self?.cache[key] == nil else { return }
        }
        
        if lruArray.count == cacheSize {
            removeLast()
        }
        
        concurrentQueue.async(flags: .barrier) {
            self.lruArray = [key] + self.lruArray
            self.cache[key] = value
        }
    }
    
    public func getObject(for key: Key) -> Value? {
        var value: Value?
        concurrentQueue.sync { [weak self] in
            value = self?.cache[key]
        }
        
        return value
    }
    
    private func removeLast() {
        concurrentQueue.async(flags: .barrier) {
            let key = self.lruArray.removeLast()
            self.cache.removeValue(forKey: key)
        }
    }
    
    
}
