//
//  FlikrCollectionViewCell.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit

class FlikrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var flickrPhoto: FlickrPhoto? {
        didSet {
            // Grab photo here
            
        }
    }
    
}
