//
//  SkiResort.swift
//  XebiaSki
//
//  Created by JC on 30/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import Foundation

public class SkiResort {
    public let name: String
    public var temperature: Int
    public var image: UIImage!

    public init(name: String, temperature: Int) {
        self.name = name
        self.temperature = temperature
    }
}