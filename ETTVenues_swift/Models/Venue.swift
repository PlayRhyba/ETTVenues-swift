//
//  Venue.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/17/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class Venue: BaseObject {
    
    let name: String?
    
    
    //MARK: Initialization
    
    
    override init(withDictionary dictionary: [String: Any]?) {
        name = dictionary?["name"] as? String
        super.init(withDictionary: dictionary)
    }
    
    
    //MARK: Public Methods
    
    
    class func venues(withDictionary dictionary: [String: Any]?) -> [Venue] {
        var result = [Venue]()
        
        let response = dictionary?["response"] as? [String: Any]
        let venues = response?["venues"] as? [[String: Any]]
        
        if venues != nil {
            for dictionary in venues! {
                let venue = Venue(withDictionary: dictionary)
                result.append(venue)
            }
        }
        
        return result
    }
}
