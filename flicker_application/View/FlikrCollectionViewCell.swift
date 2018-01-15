//
//  FlikrCollectionViewCell.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit
import AlamofireImage

class FlikrCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        self.imageView.af_cancelImageRequest()
        self.imageView.image = nil
        super.prepareForReuse()
    }
}
