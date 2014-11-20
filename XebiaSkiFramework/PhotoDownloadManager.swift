//
//  PhotoDownloadManager.swift
//  XebiaSki
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit

public typealias DownloadCallback = (NSURL?) -> ()

public class PhotoDownloadManager {

    private var photoURL: NSURL?
    
    public init() {
    }
    
    public convenience init(photoURL: NSURL) {
        self.init()
        self.photoURL = photoURL
    }
    
    public func downloadLatestPhoto(result: DownloadCallback) {
        if let URL = self.photoURL? {
            downloadPhoto(URL, result: result)
        } else {
            result(nil)
        }
    }
    
    private func downloadPhoto(URL: NSURL, result: DownloadCallback) {
        let session = NSURLSession.sharedSession()
        session.downloadTaskWithURL(URL, completionHandler: { (localURL: NSURL!, response: NSURLResponse!, error: NSError!) -> Void in
            if let HTTPResponse = response as? NSHTTPURLResponse {
                if HTTPResponse.statusCode == 200 {
                    result(localURL)
                    return;
                }
            }
            result(nil)
        }).resume()
    }
}
