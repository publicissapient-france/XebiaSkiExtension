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

    private var dataSource = WebcamDataSource()
    @IBOutlet weak var mainTable: WKInterfaceTable!
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        
        // Configure interface objects here.
        NSLog("%@ init", self)
        
        reloadTableData()
    }
    
    func reloadTableData() {
        mainTable.setNumberOfRows(self.dataSource.count, withRowType: "CameraTableRow")
        for var index = 0; index < self.dataSource.count; ++index {
            let row = mainTable.rowControllerAtIndex(index) as CameraTableRowController
            row.configureWithWebcam(self.dataSource[index])
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        //pushControllerWithName("DetailController", context: nil)
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return self.dataSource[rowIndex]
    }
}
