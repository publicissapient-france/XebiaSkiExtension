//
//  GlanceController.swift
//  XebiaSki WatchKit Extension
//
//  Created by Simone Civetta on 19/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import WatchKit
import Foundation
import XebiaSkiFramework

class GlanceController: WKInterfaceController {

    @IBOutlet weak var photoImage: WKInterfaceImage!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    private let photoPersistenceManager = PhotoPersistenceManager()
    
    override init(context: AnyObject?) {
        super.init(context: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        self.titleLabel.setText("Les Arcs")
        
        self.photoPersistenceManager.photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/mega_les-arcs_arcabulle.jpg")!)
        self.photoPersistenceManager.retrievePhoto { [weak self] (image) -> () in
            if let weakSelf = self? {
                weakSelf.photoImage.setImage(image)
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
