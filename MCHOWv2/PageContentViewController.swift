//
//  PageContentViewController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/17/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class PageContentViewController: UIViewController {
    
    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var bkImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var pageIndex: Int?
    var titleText : String!
    var imageName : String!
    var descText : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bkImageView.image = UIImage(named: imageName)
        //self.heading.text = self.titleText
        //self.heading.alpha = 0.1
        //UIView.animateWithDuration(1.0, animations: { () -> Void in
           // self.heading.alpha = 1.0
        //})
        
        //self.descLabel.text = self.descText
        //self.descLabel.alpha = 0.1
        //UIView.animateWithDuration(1.0, animations: { () -> Void in
        //    self.descLabel.alpha = 1.0
        //})
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose
    }
    
    
    
}