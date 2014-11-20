//
//  TodayViewController.swift
//  TodayPreviewExtension
//
//  Created by Simone Civetta on 11/11/14.
//  Copyright (c) 2014 Xebia IT Architechts. All rights reserved.
//

import NotificationCenter
import XebiaSkiFramework

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let photoPersistenceManager = PhotoPersistenceManager()
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        reloadPhoto()
        completionHandler(NCUpdateResult.NewData)
    }
    
    func reloadPhoto() {
        self.photoPersistenceManager.retrievePhoto {[weak self] (image) -> () in
            if let image = image? {
                self?.imageView.image = image
                let imageViewFrame:CGRect = self == nil ? CGRectZero : self!.imageView.frame
                self?.imageViewHeight.constant = image.size.height * CGRectGetWidth(imageViewFrame) / image.size.width
            }
        }
    }
}
