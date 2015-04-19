//
//  CreatePetController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/16/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class CreatePetController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //DEFINE STORYBOARD ITEMS

    @IBOutlet weak var chooseImageButton: UIButton!
    @IBOutlet weak var petNameField: UITextField!
    @IBOutlet weak var dogButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    
    var didChooseType = false
    var isDogChosen = false
    var isCatChosen = false
    
    //DEFINE IMAGE SELECTION
    var imagePicker = UIImagePickerController()
    
    //LOAD DEFAULTS
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dogChosen(sender: AnyObject) {
        didChooseType = true
        isDogChosen = true
        isCatChosen = false
        catButton.setImage(UIImage(named: "Cat.png"), forState: UIControlState.Normal)
        dogButton.setImage(UIImage(named: "Dog Selected.png"), forState: UIControlState.Normal)
        
    }
    
    @IBAction func catChosen(sender: AnyObject) {
        didChooseType = true
        isCatChosen = true
        isDogChosen = false
        catButton.setImage(UIImage(named: "Cat Selected.png"), forState: UIControlState.Normal)
        dogButton.setImage(UIImage(named: "Dog.png"), forState: UIControlState.Normal)
    }
    
    //IMAGE PICKER
    
    @IBAction func chooseImage(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            println("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }

    }
        
    
    
    //IMAGE SELECTION CONTROLLER
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        chooseImageButton.setImage(image, forState: UIControlState.Normal)
        
        var selectedImage: UIImage = image
        
        let fileManager = NSFileManager.defaultManager()
        
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        var filePathToWrite = "\(paths)/SaveFile.png"
        
        var imageData: NSData = UIImagePNGRepresentation(selectedImage)
        
        fileManager.createFileAtPath(filePathToWrite, contents: imageData, attributes: nil)

        
    }
    
    @IBAction func nextPressed(sender: UIButton) {
        
        if petNameField.text.isEmpty || didChooseType == false  {
        
            let alert = UIAlertView()
            alert.title = "Missing Fields"
            alert.message = "Please fill in the necessary information"
            alert.addButtonWithTitle("Ok")
            alert.show()
        
        }
        
        else {
            
            //check chosen type
            if isDogChosen == true {
                //set 1 for dog
                defaults.setInteger(1, forKey: "type")
            }
            if isCatChosen == true {
                //set 0 for cat
                defaults.setInteger(0, forKey: "type")
            }
            
            defaults.setObject(self.petNameField.text, forKey: "petName")
            defaults.synchronize()
            
            var vc = self.storyboard?.instantiateViewControllerWithIdentifier("petSpecifics") as PetSpecificsController
            self.presentViewController(vc, animated: true, completion: nil)

        }
    
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapRecognizer)
        
    }
    
    //When tap outside of area recognized, leave textbox editing view
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        
        self.view.endEditing(true)
        
    }
    
}

