//
//  ETTVenues_swiftTests.swift
//  ETTVenues_swiftTests
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import XCTest
import CoreLocation


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
    
    
    func testPhotoDataModel() {
        let i_dictionary = ["id": "58c1a27f7b43b418712a98ed",
                            "prefix": "https://igx.4sqi.net/img/general/",
                            "suffix": "/1322106_h4X6cYGloL7t0eirbyNlt_f87bs4XaWhFOhMF0Ib7qs.jpg"]
        
        let photo = Photo(withDictionary: i_dictionary)
        
        XCTAssertEqual(photo.id, "58c1a27f7b43b418712a98ed", "Photo initialization test failed.")
        XCTAssertEqual(photo.prefix, "https://igx.4sqi.net/img/general/", "Photo initialization test failed.")
        XCTAssertEqual(photo.suffix, "/1322106_h4X6cYGloL7t0eirbyNlt_f87bs4XaWhFOhMF0Ib7qs.jpg", "Photo initialization test failed.")
        XCTAssertNotNil(photo.previewURL(withSize: CGSize(width: 50.0, height: 50.0)), "Photo \"preview\" URL building test failed.")
        XCTAssertNotNil(photo.originalURL(), "Photo \"original\" URL building test failed.")
        
        let m_dictionary = ["response": ["photos": ["items": [
            i_dictionary,
            i_dictionary,
            ]]]]
        
        let photos = Photo.photos(withDictionary: m_dictionary)
        
        XCTAssert(photos.count == 2, "Photo multiple objects initialization test failed.")
        XCTAssertEqual(photos[0].id, "58c1a27f7b43b418712a98ed", "Photo initialization test failed.")
        XCTAssertEqual(photos[1].id, "58c1a27f7b43b418712a98ed", "Photo initialization test failed.")
    }
    
    
    func testVenueDataModel() {
        let i_dictionary = ["id": "4f60d6e2e4b02a8707792bfa",
                            "name": "Downtown San Francisco"]
        
        let venue = Venue(withDictionary: i_dictionary)
        
        XCTAssertEqual(venue.id, "4f60d6e2e4b02a8707792bfa", "Venue initialization test failed.")
        XCTAssertEqual(venue.name, "Downtown San Francisco", "Venue initialization test failed.")
        
        let m_dictionary = ["response": ["venues" : [
            i_dictionary,
            i_dictionary,
            ]]]
        
        let venues = Venue.venues(withDictionary: m_dictionary)
        XCTAssert(venues.count == 2, "Venue multiple objects initialization test failed.")
        XCTAssertEqual(venues[0].id, "4f60d6e2e4b02a8707792bfa", "Venue initialization test failed.")
        XCTAssertEqual(venues[1].id, "4f60d6e2e4b02a8707792bfa", "Venue initialization test failed.")
    }
    
    
    func testRequester() {
        let requesterExpectation = expectation(description: "Requester expectation")
        let location = CLLocation(latitude: 37.785834, longitude: -122.406417)
        
        Requester.sharedInstance.photos(withLocation: location) { (photos, error) in
            XCTAssertNil(error, String(format: "Requester test failed. Error: %@", error!.localizedDescription))
            XCTAssert(photos!.count > 0, "Requester test failed. photos.count == 0")
            XCTAssert(photos!.count <= Requester.Constants.MaxPhotosAmount, String(format: "Requester test failed. photos.count > %lu", Requester.Constants.MaxPhotosAmount))
            
            requesterExpectation.fulfill()
        }
        
        waitForExpectations(timeout: Constants.Timeout) { (error) in
            XCTAssertNil(error, String(format: "Requester test failed. Error: %@", error!.localizedDescription))
        }
    }
}
