//
//  NetworkManager.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/30/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import Foundation


class NetworkManager {
    
    func loadData<T: Decodable>(from urlString: String, completion: @escaping (T) -> ()) {
        // Create a configuration
        let configuration = URLSessionConfiguration.ephemeral
        
        // Create a session
        let session = URLSession(configuration: configuration)
        
        // Setup the url
        let url = URL(string: urlString)!
        
        // Create the task
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
                completion(object)
                
            } catch {
                print("Error info: \(error)")
            }
        }
        task.resume()
    }
}
