//
//  AqueryAPI.swift
//  Resume
//
//  Created by specktro on 5/22/19.
//  Copyright © 2019 specktro. All rights reserved.
//

import Foundation

// MARK: - QueryAPI class
/// This singleton will help to get the information for the application
final class QueryAPI {
    // MARK: - Attributes
    private var session: URLSession
    
    // MARK: - Singleton stuff
    static let shared = QueryAPI()
    
    private init() {
        self.session = URLSession(configuration: .default)
    }
    
    // MARK: - Public methods
    /**
     Gets the `Profile` struct
     
     - Parameter fail: a closure for error call back.
     - Parameter completion: a closure for success call back.
     */
    public func getProfile(fail: @escaping ((NSError) -> (Void)), completion: @escaping ((String) -> (Void))) {
        if let url = URL(string: "https://gist.githubusercontent.com/specktro/e29134eea63332a72fcf5453aec38eb9/raw/5b31b0e73b8d570ff7b2d9cc14a0b12cff199fb3/profile.json") {
            let profileTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        let myError = NSError(domain: "com.specktro.resume", code: 1000, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                        fail(myError)
                    }
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        DispatchQueue.main.async {
                            completion(jsonString)
                        }
                    }
                }
            }
            
            profileTask.resume()
        }
    }
}
