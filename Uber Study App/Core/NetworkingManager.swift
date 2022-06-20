//
//  NetworkingManager.swift
//  Uber Study App
//
//  Created by Harrison Klein on 6/18/22.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public class NetworkingManager {
    
    private var timeOut: TimeInterval
    private let urlSession = URLSession.shared
    
    init(timeOut: TimeInterval) {
        self.timeOut = timeOut
    }
    
    public func dataTask<T: Codable>(url: URL,
                                     data: Data? = nil,
                                     httpMethod: HTTPMethod,
                                     result: @escaping (Result<T, Error>) -> Void) {
        
        // TODO: Add handling for multiple requests to the same URL
        
        var urlRequest = URLRequest(url: url, timeoutInterval: timeOut)
        urlRequest.httpMethod = httpMethod.rawValue
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let data = data,
                  let object: T = try? self.decode(data)
            else {
                return
            }
            result(.success(object))
        }
        task.resume()
    }

    private func decode<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
