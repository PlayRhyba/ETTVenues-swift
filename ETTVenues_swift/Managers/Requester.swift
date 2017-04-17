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
                completion:([Photo]?, Error?) -> Void) {
        
    }
    
    
    //MARK: Internal Logic
    
    
    func venues(withLocation location: CLLocation,
                completion:([Venue]?, Error?) -> Void) {
        
    }
    
    
    func photos(withVenueID venueID: String,
                completion:([Photo]?, Error?) -> Void) {
        
    }
    
    
    func parameters() -> [String: String] {
        return ["client_id": Constants.ClientID,
                "client_secret": Constants.ClientSecret,
                "v": Constants.VersionDate]
    }
}
