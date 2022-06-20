//
//  ImageLoader.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import UIKit

class ImageLoader {
    
    private let urlSession = URLSession.shared
    private var currentTasks = [UUID: URLSessionDataTask]()
    private let lruCache = LRUCache<String, UIImage>(cacheSize: 20)
    private let concurrentQueue = DispatchQueue(label: "Concurrent Queue", attributes: .concurrent)
    
    public static let shared = ImageLoader()
    
    private init() {}
    
    public func image(for url: URL, result: @escaping (Result<UIImage, Error>) -> Void) -> UUID {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            if let image = self?.lruCache.getObject(for: url.absoluteString) {
                result(.success(image))
            }
            
        }
        let uuid = UUID()
        let task = urlSession.dataTask(with: url) { [weak self] data, response, error in
            defer {
                self?.concurrentQueue.async(flags: .barrier) {
                    self?.currentTasks[uuid] = nil
                }
            }
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data,
                  let image = UIImage(data: data)
            else {
                return
            }
            self?.concurrentQueue.async(flags: .barrier) {
                self?.lruCache.addObject(image, for: url.absoluteString)
            }
            result(.success(image))
        }
        self.concurrentQueue.async(flags: .barrier) {
            self.currentTasks[uuid] = task
        }
        task.resume()
        return uuid
    }
    
    public func cancelTask(with uuid: UUID) {
        if let task = currentTasks[uuid] {
            task.cancel()
        }
        currentTasks.removeValue(forKey: uuid)
    }
}
