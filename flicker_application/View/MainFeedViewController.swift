//
//  MainFeedViewController.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit
import AlamofireImage

class MainFeedViewController: UIViewController {
    
    var photos = [FlickrPhoto]()
    fileprivate let itemsPerRow: CGFloat = 3
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        // Try to avoid force unwrapping, but due to time...
        if searchBarTextField.text!.count > 0 {
            FlikrService.returnPhotos(itemName: searchBarTextField.text!, completion: { (error, photos) in
                self.photos = photos
                self.collectionView.reloadData()
            })
        }
    }
    
}

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"FlikrCell", for: indexPath) as! FlikrCollectionViewCell
        let photo = photos[indexPath.row]
        cell.flickrPhoto = photo
        cell.backgroundColor = .green
        cell.imageView.imageFromUrl(urlString: photo.photoUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: URL) {
        let request = URLRequest(url: urlString)
        NSURLConnection.sendAsynchronousRequest(request, queue: .main) { (response, data, error) in
             self.image = UIImage(data: data!)
        }
    }
}
