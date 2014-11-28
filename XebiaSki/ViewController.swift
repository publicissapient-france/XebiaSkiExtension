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

    let photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/mega_les-arcs_arcabulle.jpg")!)
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photoDownloadManager.retrievePhoto { (image) -> () in
            self.imageView.image = image
        }
    }
}

