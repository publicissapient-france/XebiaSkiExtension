//
//  DetailInterfaceController.swift
//  XebiaSki
//
//  Created by Simone Civetta on 02/12/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import WatchKit
import XebiaSkiFramework

class DetailInterfaceController: WKInterfaceController {
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var photoImageView: WKInterfaceImage!
    
    private let photoDownloadManager: PhotoDownloadManager?
    var webcam: Webcam?
    
    override init(context: AnyObject?) {
        if let webcam = context as? Webcam {
            self.webcam = webcam
            self.photoDownloadManager = PhotoDownloadManager(photoURL: webcam.URL)
        }
        super.init(context: context)
    }
    
    override func willActivate() {
        self.nameLabel.setText(self.webcam?.name)
        self.photoDownloadManager?.retrievePhoto({ (image) -> () in
            self.photoImageView.setImage(image)
        })
    }
}
