//
//  AppDelegate.swift
//  XebiaSki
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit
import XebiaSkiFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        application.setMinimumBackgroundFetchInterval(1.0)
        return true
    }

    func application(application: UIApplication, performFetchWithCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
        let photoPersistenceManager = PhotoPersistenceManager()
        photoPersistenceManager.photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/mega_les-arcs_arcabulle.jpg")!)
        photoPersistenceManager.retrievePhoto { (image) -> () in
            completionHandler(.NewData)
        }
    }
    
    func application(application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: () -> Void) {
        println(identifier)
    }

}

