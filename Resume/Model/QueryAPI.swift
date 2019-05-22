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
    private var profileURL: URL?
    
    // MARK: - Singleton stuff
    static let shared = QueryAPI()
    
    private init() {
        self.session = URLSession(configuration: .default)
        
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: path) as? [AnyHashable: Any],
            let urlString = plist["ProfileURL"] as? String {
            self.profileURL = URL(string: urlString)
        }
    }
    
    // MARK: - Public methods
    /**
     Gets the `Profile` struct
     
     - Parameter fail: a closure for error call back.
     - Parameter completion: a closure for success call back.
     */
    public func getProfile(fail: @escaping ((NSError) -> (Void)), completion: @escaping ((Profile) -> (Void))) {
        if let url = self.profileURL {
            let profileTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        let myError = NSError(domain: "com.specktro.resume", code: 1000, userInfo: [NSLocalizedDescriptionKey: error.localizedDescription])
                        fail(myError)
                    }
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    let jsonDecoder = JSONDecoder()
                    
                    if let profile = try? jsonDecoder.decode(Profile.self, from: data) {
                        DispatchQueue.main.async {
                            completion(profile)
                        }
                    }
                }
            }
            
            profileTask.resume()
        }
    }
}
