//
//  UIImageView + Extentions .swift
//  flicker_application
//
//  Created by Marquavious on 1/12/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    public func imageFromUrl(urlString: URL) {
        let request = URLRequest(url: urlString)
        NSURLConnection.sendAsynchronousRequest(request, queue: .main) { (response, data, error) in
            self.image = UIImage(data: data!)
        }
    }
}
