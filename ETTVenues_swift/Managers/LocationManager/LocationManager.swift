//
//  LocationManager.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    
    typealias ObservationBlock = (CLLocation?, Error?) -> Void
    
    
    struct Constants {
        static let DefaultDistanceFilter: CLLocationDistance = 200.0
    }
    
    
    static let sharedInstance = LocationManager()
    private let locationManager: CLLocationManager
    private lazy var observers = Set<LocationObserver>()
    
    
    var distanceFilter: CLLocationDistance {
        get {
            return locationManager.distanceFilter
        }
        set {
            locationManager.distanceFilter = newValue > 0 ? newValue : kCLDistanceFilterNone
        }
    }
    
    
    var observationBlocksCount: Int {
        return observers.count
    }
    
    
    //MARK: Initialization
    
    
    private override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        super.init()
        
        locationManager.delegate = self
        distanceFilter = Constants.DefaultDistanceFilter
    }
    
    
    //MARK: Public Methods
    
    
    func startObserving() {
        locationManager.startUpdatingLocation()
    }
    
    
    func stopObserving() {
        locationManager.stopUpdatingLocation()
    }
    
    
    func addObservationBlock(_ block: @escaping ObservationBlock,
                             withIdentifier identifier: String,
                             queue: DispatchQueue) {
        let observer = LocationObserver(identifier: identifier,
                                        action: block,
                                        queue: queue)
        observers.insert(observer)
    }
    
    
    func removeObservationBlock(withIdentifier identifier: String) {
        for observer in observers {
            if observer.identifier == identifier {
                observers.remove(observer)
                break
            }
        }
    }
    
    
    //MARK: CLLocationManagerDelegate
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for observer in observers {
            observer.invoke(withLocation: locations.first, error: nil)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        for observer in observers {
            observer.invoke(withLocation: nil, error: error)
        }
    }
}
