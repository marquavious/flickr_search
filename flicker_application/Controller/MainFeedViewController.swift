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

    fileprivate let cellIdentifier = "FlikrCell"
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    @IBOutlet weak var keyboardView: UIView!
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var flickrServicer = FlickrServicer(pageLimit: 20)
    private var photos = [FlickrPhoto]()
    private var isLoading = false {
        didSet { updateUI() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotifications()
    }
    
    /*
     In a bigger application, there may be various changes due to state
     The updateUI() fucntion allows us to seperate code
    */
    
    private func updateUI() {
        if isLoading {
            self.view.endEditing(true) // exit keyboard
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.keyboardView.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight)
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.keyboardView.transform = CGAffineTransform(translationX: 0, y: 0)
    }
    
    private func insertPhotos() {
        var indexPaths = [IndexPath]()
        for i in flickrServicer.pageLimit * flickrServicer.currrentPage..<photos.count {
            let indexPath = IndexPath(item: i, section: 0)
            indexPaths.append(indexPath)
        }
        collectionView?.insertItems(at: indexPaths)
    }
    
    private func performSearch() {
        guard let text = searchBarTextField.text else { return }
        isLoading = true
        flickrServicer.resetPageCount()
        photos.removeAll()
        flickrServicer.returnPhotos(itemName: text){ [weak self] error, photos in
            if error != nil { return } // handle error
            self?.photos = photos
            self?.isLoading = false
            self?.collectionView.reloadData()
        }
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        performSearch()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
}

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FlikrCollectionViewCell
        let photo = photos[indexPath.row]
        cell.imageView.af_setImage(withURL: photo.photoUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         self.view.endEditing(true)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (photos.count - 4) {
            guard let text = searchBarTextField.text else { return }
            flickrServicer.incrementPageCount()
            if flickrServicer.currrentPage < 1 { return } // If the page is on the first one, ignore
            isLoading = true
            flickrServicer.returnPhotos(itemName: text) { [weak self] error, photos in
                if error != nil { // handle error
                    self?.flickrServicer.decrementPageCount()
                    return
                }
                self?.photos.append(contentsOf: photos)
                self?.isLoading = false
                self?.insertPhotos()
            }
        }
    }
}

