//
//  PhotoCell.swift
//  ETTVenues_swift
//
//  Created by Alexander Snigurskyi on 2017-04-18.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    weak var photo: Photo! {
        didSet {
            imageView.load(withURL: photo.previewURL(withSize: imageView.frame.size))
        }
    }
}
