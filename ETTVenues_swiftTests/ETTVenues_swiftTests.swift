//
//  ETTVenues_swiftTests.swift
//  ETTVenues_swiftTests
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import XCTest


class ETTVenues_swiftTests: XCTestCase {
    
    struct Constants {
        static let Timeout: TimeInterval = 20.0
    }
    
    
    func testLocationManager() {
        let locationManager = LocationManager.sharedInstance
        
        locationManager.addObservationBlock({ (_, _) in },
                                            withIdentifier: "first",
                                            queue: DispatchQueue.main)
        
        locationManager.addObservationBlock({ (_, _) in },
                                            withIdentifier: "first",
                                            queue: DispatchQueue.main)
        
        locationManager.addObservationBlock({ (_, _) in },
                                            withIdentifier: "second",
                                            queue: DispatchQueue.main)
        
        XCTAssert(locationManager.observationBlocksCount == 2, "LocationManager test failed.")
        
        locationManager.removeObservationBlock(withIdentifier: "first")
        locationManager.removeObservationBlock(withIdentifier: "second")
        XCTAssert(locationManager.observationBlocksCount == 0, "LocationManager test failed.")
        
        let locationObserverExpectation1 = expectation(description: "Location observer expectation 1")
        let locationObserverExpectation2 = expectation(description: "Location observer expectation 2")
        
        let test: LocationManager.ObservationBlock = { (location, error) in
            XCTAssertNil(error, String(format: "LocationManager test failed. Error: %@", error!.localizedDescription))
            XCTAssertNotNil(location, "LocationManager test failed. Location is unreachable")
        }
        
        locationManager.addObservationBlock({ (location, error) in
            test(location, error)
            locationObserverExpectation1.fulfill()
        }, withIdentifier: "first", queue: DispatchQueue.main)
        
        locationManager.addObservationBlock({ (location, error) in
            test(location, error)
            locationObserverExpectation2.fulfill()
        }, withIdentifier: "second", queue: DispatchQueue.global())
        
        locationManager.startObserving()
        
        waitForExpectations(timeout: Constants.Timeout) { (error) in
            locationManager.stopObserving()
            XCTAssertNil(error, String(format: "LocationManager test failed. Error: %@", error!.localizedDescription))
        }
    }
}
