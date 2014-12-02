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

    @IBOutlet weak var group: WKInterfaceGroup!
    @IBOutlet weak var photoImage: WKInterfaceImage!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    private let photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/mega_les-arcs_arcabulle.jpg")!)
    
    override init(context: AnyObject?) {
        super.init(context: context)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        let img = UIImage(named: "les_arcs")
        let filter = CIFilter(name:"CIGaussianBlur")
        
        filter.setValue(CIImage(image: img), forKey: kCIInputImageKey)
        
        let outputImg = filter.outputImage
        var context = CIContext(options:nil)
        let cgimg = context.createCGImage(outputImg, fromRect: CGRectMake(0, 0, 800, 600))
        
        self.group.setBackgroundImage(UIImage(CGImage: cgimg))

    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
