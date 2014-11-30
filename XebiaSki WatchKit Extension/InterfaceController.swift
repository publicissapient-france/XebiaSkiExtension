//
//  InterfaceController.swift
//  XebiaSki WatchKit Extension
//
//  Created by Simone Civetta on 19/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import WatchKit
import Foundation
import XebiaSkiFramework

class InterfaceController: WKInterfaceController {
    @IBOutlet weak var labelTemperature: WKInterfaceLabel!
    @IBOutlet weak var labelDay: WKInterfaceLabel!
    @IBOutlet weak var labelResortName: WKInterfaceLabel!
    @IBOutlet weak var group: WKInterfaceGroup!

    private let photoDownloadManager = PhotoDownloadManager(photoURL: NSURL(string: "http://www.snow-forecast.com/system/images/5097/large/Les-Arcs.jpg")!)

    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        self.labelTemperature.setText(42.description + "°C")
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        photoDownloadManager.retrievePhoto { (image) -> () in
            if let img = image {
                let filter = CIFilter(name:"CIGaussianBlur")

                filter.setValue(3, forKey: kCIInputRadiusKey)
                filter.setValue(CIImage(image: img), forKey: kCIInputImageKey)

                let outputImg = filter.outputImage
                var context = CIContext(options:nil)
                var frame = outputImg.extent()
                let cgimg = context.createCGImage(outputImg, fromRect: CGRectMake(0, 0,800, 400))

                self.group.setBackgroundImage(UIImage(CGImage: cgimg))
            }
        }
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
