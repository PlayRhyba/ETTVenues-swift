//
//  LocationManager.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject {
    
    typealias ObservationBlock = (CLLocation?, Error?) -> Void
    
    private struct Constants {
        static let defaultDistanceFilter: CLLocationDistance = 200.0
    }
    
    static let shared = LocationManager()
    private let locationManager: CLLocationManager
    fileprivate lazy var observers = Set<LocationObserver>()
    
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
    
    // MARK: Initialization
    
    private override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        super.init()
        
        locationManager.delegate = self
        distanceFilter = Constants.defaultDistanceFilter
    }
    
    // MARK: Public Methods
    
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
        guard let observer = observers.first(where: { $0.identifier == identifier }) else {
            return
        }
        
        observers.remove(observer)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        observers.forEach { $0.invoke(withLocation: locations.first, error: nil) }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observers.forEach { $0.invoke(withLocation: nil, error: error) }
    }
    
}
