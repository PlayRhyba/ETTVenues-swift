//
//  PhotoViewController.swift
//  ETTVenues_swift
//
//  Created by Alexander Snigurskyi on 2017-04-18.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PhotoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    weak var photo: Photo!
    
    
    //MARK: Lifecycle
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = photo.venue?.name
        imageView.load(withURL: photo.originalURL())
    }
}
