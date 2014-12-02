//
//  CameraTableRowController.swift
//  XebiaSki
//
//  Created by Simone Civetta on 28/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import WatchKit
import XebiaSkiFramework

class CameraTableRowController: NSObject {
    @IBOutlet weak var titleLabel: WKInterfaceLabel!
    
    func configureWithWebcam(webcam: Webcam) {
        self.titleLabel.setText(webcam.name)
    }
}