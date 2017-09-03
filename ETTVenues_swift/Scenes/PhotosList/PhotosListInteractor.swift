//
//  PhotosListInteractor.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 03/09/2017.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol PhotosListBusinessLogic {
    
    func startObservingLocation()
    func stopObservingLocation()
    func fetchPreviewImage(request: PhotosList.FetchPhoto.Request)
    
}

class PhotosListInteractor {
    
    var presenter: PhotosListPresentationLogic!
    
}

extension PhotosListInteractor: PhotosListBusinessLogic {
    
    func startObservingLocation() {
        
        //TODO: Start observing location
        
    }
    
    func stopObservingLocation() {
        
        //TODO: Stop observing location
        
    }
    
    func fetchPreviewImage(request: PhotosList.FetchPhoto.Request) {
        
        //TODO: Load preview image
        
    }
    
}
