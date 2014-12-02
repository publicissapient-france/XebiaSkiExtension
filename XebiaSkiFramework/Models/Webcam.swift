//
//  Webcam.swift
//  XebiaSki
//
//  Created by Simone Civetta on 02/12/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

public class Webcam {
    public var name: String
    public var URL: NSURL
    
    public init(name: String, URL: NSURL) {
        self.name = name
        self.URL = URL
    }
}
