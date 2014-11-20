//
//  PhotoPersistenceManager.swift
//  XebiaSki
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit

public typealias PhotoCallback = (UIImage?) -> ()

public class PhotoPersistenceManager {
    
    private let lastSavedKey = "LastSaved"
    private let groupIdentifier = "group.fr.xebia.xebiaski"
    public var photoDownloadManager: PhotoDownloadManager?
    private var userDefaults: NSUserDefaults? {
        get {
            return NSUserDefaults(suiteName: self.groupIdentifier)!
        }
    }
    private let refreshInterval: NSTimeInterval = 60 * 15
    private var localPhotoURL: NSURL? {
        get {
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            if let groupContainerURL = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier(self.groupIdentifier)? {
                let photoURL = groupContainerURL.URLByAppendingPathComponent("photo.jpg")
                return photoURL
            }
            return nil
        }
    }

    public init() {
        
    }
    
    public func retrievePhoto(callback: PhotoCallback) {
        if shouldDownloadPhoto() {
            retrievePhotoFromRemote(callback)
        } else {
            retrievePhotoFromLocal(callback)
        }
    }
    
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
    
    private func retrievePhotoFromRemote(callback: PhotoCallback) {
        if let downloadManager = self.photoDownloadManager? {
            downloadManager.downloadLatestPhoto({[weak self] (URL) -> () in
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
        } else {
            callback(nil)
        }
    }

    private func retrievePhotoFromLocal(callback: PhotoCallback) {
        if let photoFileURL = self.localPhotoURL? {
            retrievePhotoFromURL(photoFileURL, callback: callback)
            return
        }
        callback(nil)
    }
    
    private func retrievePhotoFromURL(URL: NSURL, callback: PhotoCallback) {
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
}
