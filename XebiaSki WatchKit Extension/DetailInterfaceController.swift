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
    @IBOutlet weak var temperatureLabel: WKInterfaceLabel!
    @IBOutlet weak var photoImageView: WKInterfaceImage!
    @IBOutlet weak var dateLabel: WKInterfaceDate!
    
    private let photoDownloadManager: PhotoDownloadManager?
    var skiResort: SkiResort?
    
    override func awakeWithContext(context: AnyObject!) {
        super.awakeWithContext(context)

        if let skiResort = context as? SkiResort {
            self.skiResort = skiResort

            self.nameLabel.setText(skiResort.name)
            self.temperatureLabel.setText(String(skiResort.temperature) + "°C ")
        }
    }
    
    override func willActivate() {
        if let skiResort = self.skiResort? {
            self.photoDownloadManager?.retrievePhoto({ (image) -> () in
                self.photoImageView.setImage(image)
            })
        }
    }
    
    func savePreference() {
        if let skiResort = self.skiResort? {
            let archivedResort = NSKeyedArchiver.archivedDataWithRootObject(skiResort)
            NSUserDefaults.standardUserDefaults().setObject(archivedResort, forKey: "selection")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBAction func setAsDefault() {
        savePreference()
    }
}
