//
//  FlickrQueues.swift
//  flicker_application
//
//  Created by Marquavious on 1/12/18.
//  Copyright © 2018 Marquavious Draggon. All rights reserved.
//

import Foundation

public enum FlickrQueues {
    static let flikrPhotoDownload = DispatchQueue(label: "flikr_photo_download", qos: .userInitiated)
}
