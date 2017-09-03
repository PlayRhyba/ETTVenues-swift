//
//  LocationObserver.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import CoreLocation

class LocationObserver: NSObject {
    
    typealias ActionBlock = (CLLocation?, Error?) -> Void
    
    let identifier: String
    let action: ActionBlock
    let queue: DispatchQueue
    
    // MARK: Initialization
    
    init(identifier: String, action: @escaping ActionBlock, queue: DispatchQueue) {
        self.identifier = identifier
        self.action = action
        self.queue = queue
    }
    
    // MARK: Public Methods
    
    func invoke(withLocation location: CLLocation?, error: Error?) {
        queue.async {
            self.action(location, error)
        }
    }
    
}

extension LocationObserver {
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? LocationObserver {
            return identifier == other.identifier
        }
        
        return false
    }
    
    override var hash: Int {
        return identifier.hash
    }

}
