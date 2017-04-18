//
//  ViewController.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 4/16/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit


class PhotosViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [Photo]()
    
    
    //MARK: Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.sharedInstance.addObservationBlock({ (location, error) in
            if let loc = location {
                NSLog("LOCATION UPDATED: %@", loc)
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
                Requester.sharedInstance.photos(withLocation: loc,
                                                completion: { (photos, errpr) in
                                                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                                    self.photos = photos!
                                                    self.collectionView.reloadData()
                })
            }
            else {
                NSLog("LOCATION UPDATING ERROR: %@", error!.localizedDescription)
            }
        }, withIdentifier: NSStringFromClass(type(of: self)), queue: DispatchQueue.main)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        LocationManager.sharedInstance.startObserving()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        LocationManager.sharedInstance.stopObserving()
    }
    
    
    //MARK: Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is PhotoCell && segue.destination is PhotoViewController {
            (segue.destination as! PhotoViewController).photo = (sender as! PhotoCell).photo
        }
    }
    
    
    //MARK: UICollectionViewDataSource
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photo = photos[indexPath.row]
        return cell
    }
}

