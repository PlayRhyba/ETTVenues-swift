//
//  PhotosListViewController.swift
//  ETTVenues_swift
//
//  Created by Alexander Snegursky on 03/09/2017.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//

import UIKit

protocol PhotosListDisplayLogic: class {
    
    func displayPreviews(_ previews:[PhotosList.FetchPreviews.ViewModel.PhotoPreview])
    func updatePreviewImage(_ image: UIImage?, at indexPath:IndexPath)
    
}

class PhotosListViewController: UIViewController {
    
    fileprivate var interactor: PhotosListBusinessLogic!
    fileprivate var router: PhotosListRoutingLogic!
    fileprivate var previews:  [PhotosList.FetchPreviews.ViewModel.PhotoPreview] = []
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    // MARK: Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.startObservingLocation()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.stopObservingLocation()
    }
    
    // MARK: Setup
    
    private func setup() {
        let interactor = PhotosListInteractor()
        let presenter = PhotosListPresenter()
        let router = PhotosListRouter()
        
        self.interactor = interactor
        self.router = router
        
        interactor.presenter = presenter
        presenter.viewController = self
        
        router.viewController = self
    }
    
}

extension PhotosListViewController: PhotosListDisplayLogic {
    
    func displayPreviews(_ previews: [PhotosList.FetchPreviews.ViewModel.PhotoPreview]) {
        self.previews = previews
        collectionView.reloadData()
    }
    
    func updatePreviewImage(_ image: UIImage?, at indexPath:IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
        cell.imageView.image = image
        cell.stopSpinnerAnimation()
    }
    
}

extension PhotosListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return previews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.startSpinnerAnimation()
        
        let preview = previews[indexPath.row]
        let request = PhotosList.FetchPhoto.Request(id: preview.id)
        interactor.fetchPreviewImage(request: request)
        
        return cell
    }
    
}
