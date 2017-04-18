//
//  BaseObject.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/17/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class BaseObject: NSObject {
    
    let id: String?
    
    
    //MARK: Initialization
    
    
    init(withDictionary dictionary: [String: Any]?) {
        id = dictionary?["id"] as? String
        super.init()
    }
}
