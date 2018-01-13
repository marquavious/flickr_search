//
//  MainFeedViewController.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit

class MainFeedViewController: UIViewController {
    
    fileprivate let cellIdentifier = "FlikrCell"
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    fileprivate var photos = [FlickrPhoto](){
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isLoading = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {

        guard let text = searchBarTextField.text else { return }
        self.isLoading = true
        self.view.endEditing(true) // exit keyboard
        
        FlickrService.returnPhotos(itemName: text){[unowned self] error, photos in
            if let error = error {print(error)}
            self.photos = photos
            self.isLoading = false
        }
    }
    
}

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FlikrCollectionViewCell
        let photo = photos[indexPath.row]
        cell.imageView.imageFromUrl(urlString: photo.photoUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // Inspired by https://www.raywenderlich.com/136159/uicollectionview-tutorial-getting-started
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

