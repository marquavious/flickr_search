//
//  FlickrAPI.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import Alamofire

public enum FlickrAPIParameters {
    static func searchParams(page: Int, searchValue: String, limit: Int) -> [String:Any] {
            return [
            "text":searchValue,
             "extras":"url_s",
             "method":"flickr.photos.search",
             "format":"json",
             "nojsoncallback":1,
             "page": page,
             "per_page": limit,
             "api_key": ApiKeys.flickrApiKey
            ]
    }
    
    static let headers: HTTPHeaders = [
        "api_key": ApiKeys.flickrApiKey
    ]
    
}

public enum FlickrAPIDataModel {
    
    static let id = "id"
    static let owner = "owner"
    static let secret = "secret"
    static let server = "server"
    static let farm = "farm"
    static let title = "title"
    static let isPublic = "ispublic"
    static let isFriend = "isfriend"
    static let isFamily = "isfamily"
    static let photoUrl = "url_s"
    static let photoHeight = "height_s"
    static let photoWidth = "width_s"
    
}

public enum FlickrUrl {
    static var baseUrl: URL? {
        get {
            var url = URLComponents()
            url.scheme = "https"
            url.host = "api.flickr.com"
            url.path = "/services/rest/"
            do {
                return try url.asURL()
            } catch {
                print("Error creating url")
                return nil
            }
        }
    }
}

public enum FlickrJSON {
    static let photo = "photo"
    static let photos = "photos"
}











