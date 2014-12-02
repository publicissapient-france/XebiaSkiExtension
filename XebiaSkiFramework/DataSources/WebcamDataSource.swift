//
//  WebcamDataSource.swift
//  XebiaSki
//
//  Created by Simone Civetta on 02/12/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import UIKit

public class WebcamDataSource {
    var allObjects: Array<Webcam>
    
    public init() {
        self.allObjects = [
            Webcam(name: "Arcabulle", URL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/les-arcs_arcabulle.jpg")!),
            Webcam(name: "Arcs 1600 Pistes", URL: NSURL(string: "http://static1.lesarcsnet.com/image_uploader/webcam/large/lesarcs-1600-cam.jpg")!),
            Webcam(name: "Vanoise Express", URL: NSURL(string: "http://trinum.com/ibox/ftpcam/Peisey-Vallandry_vanoise-expresse.jpg")!),
            Webcam(name: "Arc 1950 Village", URL: NSURL(string: "http://www.trinum.com/ibox/ftpcam/arc-1950-haut-village.jpg")!)
        ]
    }

    public var count: Int {
        get {
            return self.allObjects.count
        }
    }
    
    public subscript(index: Int) -> Webcam {
        return self.allObjects[index]
    }
}
