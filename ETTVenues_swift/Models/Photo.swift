//
//  Photo.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/17/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import UIKit

class Photo: BaseObject {
    
    let prefix: String?
    let suffix: String?
    var venue: Venue?
    
    // MARK: Initialization
    
    override init(withDictionary dictionary: [String: Any]?) {
        prefix = dictionary?["prefix"] as? String
        suffix = dictionary?["suffix"] as? String
        
        super.init(withDictionary: dictionary)
    }
    
    // MARK: Public Methods
    
    class func photos(withDictionary dictionary: [String: Any]?) -> [Photo] {
        var result: [Photo] = []
        
        let response = dictionary?["response"] as? [String: Any]
        let photos = response?["photos"] as? [String: Any]
        let items = photos?["items"] as? [[String: Any]]
        
        if let items = items {
            for dictionary in items {
                let photo = Photo(withDictionary: dictionary)
                result.append(photo)
            }
        }
        
        return result
    }
    
    func previewURL(withSize size: CGSize) -> URL? {
        let cap: Int = (Int)(max(size.width, size.height)) * 2
        return url(withPhotoSize: String(format: "cap%d", cap))
    }
    
    func originalURL() -> URL? {
        return url(withPhotoSize: "original")
    }
    
    // MARK: Internal Logic
    
    private func url(withPhotoSize size: String) -> URL? {
        guard let prefix = prefix,
            let suffix = suffix else { return nil }
        
        return URL(string: prefix)?
            .appendingPathComponent(size)
            .appendingPathComponent(suffix)
    }
    
}
