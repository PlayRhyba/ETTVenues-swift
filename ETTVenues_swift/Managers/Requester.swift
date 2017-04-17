//
//  Requester.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/17/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreLocation
import AFNetworking


class Requester: NSObject {
    
    struct Constants {
        static let MaxPhotosAmount = 100
        static let BaseURL = "https://api.foursquare.com"
        static let ClientID = "LOCC0VDDYUO4YYZTBDAWR3ASJOLOG4BYEIUQUYK4RZGBKP5M"
        static let ClientSecret = "HSK400P2UBYM2G30MAMJGOWC3WI51PXRVMKBNN2DK4RN3YFI"
        static let VersionDate = "20170316"
        static let VenuesLimit = 50
    }
    
    
    let sessionManager: AFHTTPSessionManager
    static let sharedInstance = Requester()
    
    
    //MARK: Initialization
    
    
    private override init() {
        sessionManager = AFHTTPSessionManager(baseURL: URL(string: Constants.BaseURL))
        super.init()
    }
    
    
    //MARK: Public Methods
    
    
    func photos(withLocation location: CLLocation,
                completion:@escaping ([Photo]?, Error?) -> Void) {
        venues(withLocation: location) { (venues, error) in
            if error != nil {
                completion(nil, error)
            }
            else {
                
            }
        }
    }
    
    
    //MARK: Internal Logic
    
    
    func venues(withLocation location: CLLocation,
                completion:@escaping ([Venue]?, Error?) -> Void) {
        let parameters = commonParameters()
        
        parameters.addEntries(from: ["limit": Constants.VenuesLimit,
                                     "ll": String(format: "%lf,%lf",
                                                  location.coordinate.latitude,
                                                  location.coordinate.longitude)])
        
        sessionManager.get("v2/venues/search",
                           parameters: parameters,
                           progress: nil,
                           success: { (_, response) in
                            if let r = response as? [String: Any] {
                                let venues = Venue.venues(withDictionary: r)
                                completion(venues, nil)
                            }
                            else {
                                completion(nil, Errors.unexpectedResponseDataStructureError())
                            }
                            
        }) { (_, error) in
            completion(nil, error)
        }
    }
    
    
    func photos(withVenueID venueID: String,
                completion:@escaping ([Photo]?, Error?) -> Void) {
        let parameters = commonParameters()
        parameters.addEntries(from: ["limit": Constants.MaxPhotosAmount])
        
        sessionManager.get(String(format: "v2/venues/%@/photos", venueID),
                           parameters: parameters,
                           progress: nil,
                           success: { (_, response) in
                            if let r = response as? [String: Any] {
                                let photos = Photo.photos(withDictionary: r)
                                completion(photos, nil)
                            }
                            else {
                                completion(nil, Errors.unexpectedResponseDataStructureError())
                            }
        }) { (_, error) in
            completion(nil, error)
        }
    }
    
    
    func commonParameters() -> NSMutableDictionary {
        return ["client_id": Constants.ClientID,
                "client_secret": Constants.ClientSecret,
                "v": Constants.VersionDate]
    }
}
