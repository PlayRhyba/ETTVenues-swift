//
//  PhotosListPresenter.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 03/09/2017.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import Foundation

protocol PhotosListPresentationLogic {
    
    func presentPreviews(response: PhotosList.FetchPreviews.Response)
    
}

class PhotosListPresenter {
    
    weak var viewController: PhotosListDisplayLogic?
    
}

extension PhotosListPresenter: PhotosListPresentationLogic {
    
    func presentPreviews(response: PhotosList.FetchPreviews.Response) {
        
        //TODO: Transform response to viewModel and send to ViewController
        
    }
    
}
