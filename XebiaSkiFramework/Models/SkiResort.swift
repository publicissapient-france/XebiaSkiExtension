//
//  SkiResort.swift
//  XebiaSki
//
//  Created by JC on 30/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

public class SkiResort {
    public var name: String
    public var photoURL: NSURL
    public var temperature: Int
    
    public init(name: String, photoURL: NSURL, temperature: Int) {
        self.name = name
        self.photoURL = photoURL
        self.temperature = temperature
    }
}
