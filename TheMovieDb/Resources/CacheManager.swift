//
//  CacheManager.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 26/01/22.
//

import Foundation
import UIKit

class CacheManager {
    static let shared = CacheManager()
    
    // private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 1000
        return cache
    }()
    
    func addToCache(image: UIImage, name: String) {        
//        print("Adding \(name) to cache")
        imageCache.setObject(image, forKey: name as NSString)
    }
    
    func removeFromCache(name: String) {
        imageCache.removeObject(forKey: name as NSString)
    }
    
    func getFromCache(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
}
