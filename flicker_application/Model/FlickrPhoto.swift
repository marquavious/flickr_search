//
//  FlickrPhoto.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON


class FlickrPhoto {

    var id: String
    var owner: String
    var secret: String
    var server: String
    var farm: Int
    var title: String
    var isPublic: Bool
    var isFamily: Bool
    var isFriend: Bool
    var photoUrl: URL
    var photoHeight: Int
    var photoWidth: Int
    
    init?(_ json: JSON){
        guard let id = json[FlickrAPIDataModel.id].string,
        let owner = json[FlickrAPIDataModel.owner].string,
        let secret = json[FlickrAPIDataModel.secret].string,
        let server = json[FlickrAPIDataModel.server].string,
        let farm = json[FlickrAPIDataModel.farm].int,
        let title = json[FlickrAPIDataModel.title].string,
        let isPublic = json[FlickrAPIDataModel.isPublic].int,
        let isFamily = json[FlickrAPIDataModel.isFamily].int,
        let isFriend = json[FlickrAPIDataModel.isFriend].int,
        let photoUrl = json[FlickrAPIDataModel.photoUrl].url,
        let photoHeight = json[FlickrAPIDataModel.photoHeight].string,
        let photoWidth = json[FlickrAPIDataModel.photoWidth].string
        else { return nil }
        
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.farm = farm
        self.title = title
        self.isPublic = (isPublic == 1)
        self.isFamily = (isFamily == 1)
        self.isFriend = (isFriend == 1)
        self.photoUrl = photoUrl
        
        // If the string cannot be converted to Int, return 100 as default
        self.photoHeight = Int(photoHeight) != nil ? Int(photoHeight)! : 100
        self.photoWidth = Int(photoWidth) != nil ? Int(photoHeight)! : 100
    }

}
