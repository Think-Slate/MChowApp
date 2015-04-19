//
//  PetSpecificsController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/16/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class PetSpecificsController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //DEFINE BUTTONS AND OBJECTS
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    @IBOutlet weak var breedPicker: UIPickerView!
    @IBOutlet weak var brandPicker: UIPickerView!
    
    var imageis: UIImage!
    var defaults = NSUserDefaults.standardUserDefaults()
    
    var didChooseGender = false
    var maleChosen = false
    var femaleChosen = false
    
    let breedData = ["Choose Later", "Golden Retriever","Black Lab","Beagle","Husky","Chihuahua","Poodle"]
    
    let brandData = ["Choose Later", "Kibble", "Beneful", "Whiskas", "MeowMix", "Purina", "Friskies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        petName.text = defaults.stringForKey("petName")
        
        breedPicker.tag = 0
        breedPicker.dataSource = self
        breedPicker.delegate = self
        
        brandPicker.tag = 1
        brandPicker.dataSource = self
        brandPicker.delegate = self
        
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
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return breedData.count
        }
        else{
            return brandData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0{
            return breedData[row]
        }
        else{
            return brandData[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            defaults.setObject(breedData[row], forKey: "breed")
        }
        else{
            defaults.setObject(brandData[row], forKey: "brand")
        }
    }
    
    
    @IBAction func maleChosen(sender: UIButton) {
        didChooseGender = true
        maleChosen = true
        femaleChosen = false
        maleButton.setImage(UIImage(named: "MaleSelected.png"), forState: UIControlState.Normal)
        femaleButton.setImage(UIImage(named: "Female.png"), forState: UIControlState.Normal)
    }
    
    
    @IBAction func femaleChosen(sender: UIButton) {
        didChooseGender = true
        femaleChosen = true
        maleChosen = false
        maleButton.setImage(UIImage(named: "Male.png"), forState: UIControlState.Normal)
        femaleButton.setImage(UIImage(named: "FemaleSelected.png"), forState: UIControlState.Normal)
    }
    
    @IBAction func nextClicked(sender: AnyObject) {
        
        if didChooseGender == true { //check if gender was chosen
            if maleChosen == true{
                //set 1 if male chosen
                defaults.setInteger(1, forKey: "gender")
            }
            if femaleChosen == true {
                //set 0 is female chosen
                defaults.setInteger(0, forKey: "gender")
            }
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}


