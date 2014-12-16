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

class MasterInterfaceController: WKInterfaceController {
    @IBOutlet weak var mainTable: WKInterfaceTable!

    private var dataSource = WebcamDataSource()

    override init() {
        super.init()
        
        reloadTableData()
    }
    
    func reloadTableData() {
        mainTable.setNumberOfRows(self.dataSource.count, withRowType: "CameraTableRow")
        for var index = 0; index < self.dataSource.count; ++index {
            let row = mainTable.rowControllerAtIndex(index) as CameraTableRowController
            row.configureWithSkiResort(self.dataSource[index])
        }
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return self.dataSource[rowIndex]
    }
}
