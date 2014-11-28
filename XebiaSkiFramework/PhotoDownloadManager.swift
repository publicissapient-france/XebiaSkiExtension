//
//  PhotoDownloadManager.swift
//  XebiaSki
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit

public typealias RetrieveCallback = (UIImage?) -> ()
public typealias DownloadCallback = (NSURL?) -> ()

public class PhotoDownloadManager {

    private var photoURL: NSURL
    private let lastSavedKey = "LastSaved"
    private var userDefaults: NSUserDefaults? {
        get {
            return NSUserDefaults.standardUserDefaults()
        }
    }
    private let refreshInterval: NSTimeInterval = 60 * 15
    
    public init(photoURL: NSURL) {
        self.photoURL = photoURL
    }
    
    private var localPhotoURL: NSURL? {
        get {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            if let documentsDirectory: NSString = paths[0] as? NSString {
                let encodedRemoteURL = CFURLCreateStringByAddingPercentEscapes(nil, self.photoURL.absoluteString!, nil, "!*'\"();:@&=+$,/?%#[]% ", CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))
                let photoURL = NSURL.fileURLWithPath(documentsDirectory.stringByAppendingPathComponent(encodedRemoteURL))
                return photoURL
            }
            return nil
        }
    }
    
    // MARK: Entry point
    
    public func retrievePhoto(callback: RetrieveCallback) {
        if shouldDownloadPhoto() {
            retrievePhotoFromRemote(callback)
        } else {
            retrievePhotoFromLocal(callback)
        }
    }
    
    // MARK: Cache
    
    private func shouldDownloadPhoto() -> Bool {
        if let lastSaved = self.lastSaved() {
            let futureDate = NSDate().dateByAddingTimeInterval(self.refreshInterval)
            return lastSaved.compare(futureDate) == NSComparisonResult.OrderedDescending
        }
        return true
    }
    
    private func registerTimeStamp() {
        self.userDefaults?.setObject(NSDate(), forKey: self.lastSavedKey)
        self.userDefaults?.synchronize()
    }
    
    private func retrievePhotoFromLocal(callback: RetrieveCallback) {
        if let photoFileURL = self.localPhotoURL? {
            retrievePhotoFromLocalURL(photoFileURL, callback: callback)
            return
        }
        callback(nil)
    }
    
    private func retrievePhotoFromLocalURL(URL: NSURL, callback: RetrieveCallback) {
        var photo: UIImage?
        if let photoData = NSData(contentsOfURL: URL)? {
            photo = UIImage(data: photoData)
        }
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            callback(photo)
        })
    }
    
    private func savePhoto(URL: NSURL) {
        let fileManager = NSFileManager.defaultManager()
        if let photoFileURL = self.localPhotoURL? {
            fileManager.copyItemAtURL(URL, toURL: photoFileURL, error: nil)
        }
    }
    
    public func lastSaved() -> NSDate? {
        return self.userDefaults?.objectForKey(self.lastSavedKey)? as? NSDate
    }
    
    // MARK: Download
    
    private func retrievePhotoFromRemote(callback: RetrieveCallback) {
        downloadLatestPhoto({[weak self] (URL) -> () in
            if self == nil {
                callback(nil)
                return;
            }
            if let URLToSave = URL? {
                self?.savePhoto(URLToSave)
                self?.registerTimeStamp()
                self?.retrievePhotoFromLocal(callback)
                return;
            }
            callback(nil)
        })
    }
    
    public func downloadLatestPhoto(result: DownloadCallback) {
        downloadPhoto(self.photoURL, result: result)
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
