//
//  FlikrService.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct FlikrService {
    
    typealias ReturnPhotosCompletion = (Error?,[FlickrPhoto]) -> ()
    
    static func returnPhotos(itemName:String, completion:@escaping ReturnPhotosCompletion){
        
        // This is REALLY BAD TODO, but due to time, shpuld go into a header file the apiKey
        let params = ["text":itemName, "api_key": ApiKeys.apiKey,"extras":"url_s", "format":"json", "nojsoncallback":1] as [String : Any]
        var tempPhotoArray = [FlickrPhoto]()
        
        let serialQueue = DispatchQueue(label: "flikr_download", qos: .userInitiated)
        
        Alamofire.request(FlikerAPI.baseUrl, method: .post, parameters: params).responseJSON(queue:serialQueue){ (data) in
            
            let json = JSON(data.value as Any)
            print(json)
            for jsonObject in json["photos"]["photo"].arrayValue {
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
