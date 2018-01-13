//
//  ApiKeys.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import UIKit

struct ApiKeys{
    static var flickrApiKey:String {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.FlickrAPIKey
        }
    }
}
