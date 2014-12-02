//
//  SkiResort.swift
//  XebiaSki
//
//  Created by JC on 30/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

public class SkiResort: NSObject, NSCoding {
    public var name: String
    public var photoURL: NSURL
    public var temperature: Int
    
    public init(name: String, photoURL: NSURL, temperature: Int) {
        self.name = name
        self.photoURL = photoURL
        self.temperature = temperature
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.valueForKey("name") as String
        self.photoURL = NSURL(string: aDecoder.valueForKey("photoURL") as String)!
        self.temperature = aDecoder.valueForKey("temperature") as Int
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.setValue(self.name, forKey: "name")
        aCoder.setValue(self.photoURL.absoluteString, forKey: "photoURL")
        aCoder.setValue(self.temperature, forKey: "temperature")
    }
}
