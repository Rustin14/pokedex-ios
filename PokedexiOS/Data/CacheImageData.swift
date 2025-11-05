//
//  CacheImageData.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 22/09/25.
//

import Foundation


class CacheImageData {
    
    let cache: URLCache = URLCache(
        memoryCapacity: .memoryCapacityFiftyMegs,
        diskCapacity: .memoryCapacityOneHundredMegs
    )
    
    // Load image with automatic cache
    func loadImageWithCache(from url: URL, completion: @escaping (Data?) -> Void) {
        let request: URLRequest = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data: Data = data else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(data)
            }
        }.resume()
    }
    
    
}
