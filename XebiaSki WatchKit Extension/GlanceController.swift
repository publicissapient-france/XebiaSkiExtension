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
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    @IBOutlet weak var dateLabel: WKInterfaceDate!
    
    private var photoDownloadManager: PhotoDownloadManager?
    
    var selectedSkiResort: SkiResort? {
        get {
            if let data = NSUserDefaults.standardUserDefaults().valueForKey("selection")? as? NSData {
                return NSKeyedUnarchiver.unarchiveObjectWithData(data) as? SkiResort
            }
            return nil
        }
    }
    
    override init(context: AnyObject?) {
        super.init(context: context)
    }

    override func willActivate() {
        super.willActivate()
        
        if let skiResort = self.selectedSkiResort? {
            self.photoDownloadManager = PhotoDownloadManager(photoURL: skiResort.photoURL)
            self.photoDownloadManager?.retrievePhoto({ [weak self] (image) -> () in
                if let weakSelf = self? {
                    weakSelf.setBackgroundImage(image as UIImage?)
                }
            })
            self.titleLabel.setText(skiResort.name)
            self.temperatureLabel.setText(String(skiResort.temperature) + "°C ")
        } else {
            setBackgroundImage(nil)
            self.titleLabel.setText("")
            self.temperatureLabel.setText("")
            self.dateLabel.setHidden(true)
        }

    }
    
    func setBackgroundImage(image: UIImage?) {
        if image == nil {
            self.group.setBackgroundImage(blurImage(UIImage(named: "les_arcs")!))
        } else {
            self.group.setBackgroundImage(blurImage(image!))
        }
    }
    
    func blurImage(image: UIImage) -> UIImage? {
        let filter = CIFilter(name:"CIGaussianBlur")
        filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
        
        let outputImg = filter.outputImage
        var context = CIContext(options:nil)
        let cgimg = context.createCGImage(outputImg, fromRect: CGRectMake(0, 0, min(image.size.width, 600), min(image.size.height, 600)))
        return UIImage(CGImage: cgimg)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

}
