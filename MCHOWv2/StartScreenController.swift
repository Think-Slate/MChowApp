//
//  ViewController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/15/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import UIKit

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

