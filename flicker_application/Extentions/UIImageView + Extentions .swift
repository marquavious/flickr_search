//
//  UIImageView + Extentions .swift
//  flicker_application
//
//  Created by Marquavious on 1/12/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import UIKit
extension UIImageView {
    public func imageFromUrl(urlString: URL) {
        let request = URLRequest(url: urlString)
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async { self.image = UIImage(data: data!) }
        }.resume()
    }
}
