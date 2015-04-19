//
//  PetInfoController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/19/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class PetInfoController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petGender: UILabel!
    @IBOutlet weak var petType: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    @IBOutlet weak var petWeight: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petBrand: UILabel!
    
    var imageis: UIImage!
    
    @IBOutlet weak var petImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        petName.text = defaults.stringForKey("petName")

        if defaults.integerForKey("gender") == 1{
            petGender.text = "Male"
        }
        if defaults.integerForKey("gender") == 0{
            petGender.text = "Female"
        }
        if defaults.integerForKey("type") == 1{
            petType.text = "Dog"
        }
        if defaults.integerForKey("type") == 0{
            petType.text = "Cat"
        }
        
        petBreed.text = defaults.stringForKey("breed")
        petWeight.text = defaults.stringForKey("weight")
        petAge.text = defaults.stringForKey("age")
        petBrand.text = defaults.stringForKey("brand")
        
        getImage()
        
        petImage.image = imageis
        
        
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