//
//  PhotosListModels.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 03/09/2017.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import UIKit

enum PhotosList {
    
    // MARK: Use cases
    
    enum FetchPreviews {
        
        struct Request {}
        
        struct Response {
            
            var previews: [Photo]
            
        }
        
        struct ViewModel {
            
            struct PhotoPreview {
                
                var id: String
                var url: URL
                
            }
            
            var previews: [PhotoPreview]
            
        }
        
    }
    
    enum FetchPhoto {
        
        struct Request {
            
            var id: String
            
        }
        
        struct Response {
            
            var image: UIImage?
            
        }
        
        struct ViewModel {
            
            var image: UIImage?
            
        }
        
    }
    
}

