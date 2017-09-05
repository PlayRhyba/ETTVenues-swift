//
//  PhotosListInteractor.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 03/09/2017.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import UIKit

protocol PhotosListBusinessLogic {
    
    func startObservingLocation()
    func stopObservingLocation()
    func fetchPreviewImage(request: PhotosList.FetchPhoto.Request)
    
}

class PhotosListInteractor {
    
    var presenter: PhotosListPresentationLogic?
    
    // MARK: Initialization
    
    init() {
        LocationManager.shared.addObservationBlock({ (location, error) in
            if let location = location {
                NSLog("LOCATION UPDATED: %@", location)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                Requester.shared.photos(withLocation: location,
                                        completion: { (photos, errpr) in
                                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                            
                                            let response = PhotosList.FetchPreviews.Response(photos: photos ?? [])
                                            self.presenter?.presentPreviews(response: response)
                })
            }
            else {
                NSLog("LOCATION UPDATING ERROR: %@", error!.localizedDescription)
            }
        }, withIdentifier: NSStringFromClass(type(of: self)), queue: DispatchQueue.main)
    }
    
    deinit {
        LocationManager.shared.removeObservationBlock(withIdentifier: NSStringFromClass(type(of: self)))
    }
    
}

extension PhotosListInteractor: PhotosListBusinessLogic {
    
    func startObservingLocation() {
        LocationManager.shared.startObserving()
    }
    
    func stopObservingLocation() {
        LocationManager.shared.stopObserving()
    }
    
    func fetchPreviewImage(request: PhotosList.FetchPhoto.Request) {
        
        //TODO: Load preview image
        
    }
    
}
