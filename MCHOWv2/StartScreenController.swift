//
//  ViewController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/15/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import UIKit

extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
}

class StartScreenController: UIViewController {

    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var goToPet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if defaults.integerForKey("hasCreatedPet") == 1 {
            goToPet.hidden = false
        }
        else {
            goToPet.hidden = true
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

