//
//  FlickrServicer.swift
//  flicker_application
//
//  Created by Marquavious on 1/8/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FlickrServicer {
    
    var pageLimit: Int
    var currrentPage = 0
    
    typealias ReturnPhotosCompletion = (Error?,[FlickrPhoto]) -> ()
    
    init(pageLimit:Int = 20){
        self.pageLimit = pageLimit > 5 ? pageLimit: 20 // must be above 5
    }
    
    func returnPhotos(itemName: String, completion: @escaping ReturnPhotosCompletion) {
        
        let params = FlickrAPIParameters.searchParams(page: currrentPage, searchValue: itemName, limit: pageLimit)
        guard let url = FlickrUrl.baseUrl else { return }
        
        Alamofire.request(url, method: .post, parameters: params)
            .responseJSON(queue:FlickrQueues.flikrPhotoDownload) { (data) in
                
                let response = data.response?.statusCode
                
                if response != 200 { // handle error here
                    return
                }
                
                let json = JSON(data.value as Any)
                let photoArray = json[FlickrJSON.photos][FlickrJSON.photo].arrayValue
                
                DispatchQueue.main.async {
                    return completion(nil,photoArray.flatMap({FlickrPhoto($0)}))
                }
        }
    }
    
    func incrementPageCount(){
        self.currrentPage += 1
    }
    
    func decrementPageCount(){
        self.currrentPage -= 1
    }
    
    func resetPageCount(){
         self.currrentPage = 0
    }
}
