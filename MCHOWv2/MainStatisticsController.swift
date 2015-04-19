//
//  MainStatisticsController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/19/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class MainStatisticsController: UIViewController {
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    var imageis: UIImage!
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        defaults.setInteger(1, forKey: "hasCreatedPet")
        defaults.synchronize()
        
        getImage()
        petImage.image = imageis
        petName.text = defaults.stringForKey("petName")
        
        
    }
    
    func getImage() {
        
        
        let fileManager = NSFileManager.defaultManager()
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        var filePathToWrite = "\(paths)/SaveFile.png"
        
        var getImagePath = paths.stringByAppendingPathComponent("SaveFile.png")
        
        if (fileManager.fileExistsAtPath(getImagePath))
        {
            println("FILE AVAILABLE");
            
            //Pick Image and Use accordingly
            imageis = UIImage(contentsOfFile: getImagePath)!
            
            let data: NSData = UIImagePNGRepresentation(imageis)
            
        }
        else
        {
            println("FILE NOT AVAILABLE");
            
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}