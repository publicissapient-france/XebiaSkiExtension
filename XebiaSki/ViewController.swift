//
//  ViewController.swift
//  XebiaSki
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit
import XebiaSkiFramework

class ViewController: UIViewController {

    let photoPersistenceManager = PhotoPersistenceManager()
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoPersistenceManager.photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/mega_les-arcs_arcabulle.jpg")!)
        self.photoPersistenceManager.retrievePhoto { (image) -> () in
            self.imageView.image = image
        }
    }
}

