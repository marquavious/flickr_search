//
//  FlickrService.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct FlickrService {
    
    typealias ReturnPhotosCompletion = (Error?,[FlickrPhoto]) -> ()
    
    static func returnPhotos(itemName: String, completion:@escaping ReturnPhotosCompletion) {

        var tempPhotoArray = [FlickrPhoto]()
        let params = FlickrParameters.returnSearchParams(searchValue: itemName)
        guard let url = FlickrUrl.baseUrl else {return}
        
        Alamofire.request(url, method: .post, parameters: params)
            .responseJSON(queue:FlickrQueues.flikrPhotoDownload) { (data) in
            
            let json = JSON(data.value as Any)
            for jsonObject in json[FlickrJSON.photos][FlickrJSON.photo].arrayValue {
                if let photoObject = FlickrPhoto(jsonObject) {
                    tempPhotoArray.append(photoObject)
                }
            }
            
            DispatchQueue.main.async {
                return completion(nil,tempPhotoArray)
            }
        }
    }
}
