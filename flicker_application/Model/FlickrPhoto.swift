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
        guard let id = json[FlikerAPI.id].string,
        let owner = json[FlikerAPI.owner].string,
        let secret = json[FlikerAPI.secret].string,
        let server = json[FlikerAPI.server].string,
        let farm = json[FlikerAPI.farm].int,
        let title = json[FlikerAPI.title].string,
        let isPublic = json[FlikerAPI.isPublic].int,
        let isFamily = json[FlikerAPI.isFamily].int,
        let isFriend = json[FlikerAPI.isFriend].int,
        let photoUrl = json[FlikerAPI.photoUrl].url,
        let photoHeight = json[FlikerAPI.photoHeight].string,
        let photoWidth = json[FlikerAPI.photoWidth].string
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
        self.photoHeight = Int(photoHeight)! // Fix later
        self.photoWidth = Int(photoWidth)! // Fix later
    }

}
