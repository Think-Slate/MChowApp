//
//  WeightAgeController.swift
//  MCHOWv2
//
//  Created by Gianluca Capraro on 3/27/15.
//  Copyright (c) 2015 think.slate. All rights reserved.
//

import Foundation
import UIKit

class WeightAgeController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var weightPicker: UIPickerView!
    @IBOutlet weak var agePicker: UIPickerView!
    
    let weightData = ["Choose Later", "10-20 lbs", "20-30 lbs", "30-40 lbs", "40-50 lbs", "50-60 lbs", "60-70 lbs", "70-80 lbs", "90-100 lbs", "100-110 lbs", "110-120 lbs", "120-130 lbs", "130-140 lbs", "140-150 lbs"]
    
    let ageData = ["Choose Later", " < 1 year", "1 year", "2 years", "3 years", "4 years", "5 years", "6 years", "7 years", "8 years", "9 years", "10 years", "11 years", "12 years", "13 years", "14 years", "15 years"]
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        weightPicker.tag = 0
        weightPicker.dataSource = self
        weightPicker.delegate = self
        
        agePicker.tag = 1
        agePicker.dataSource = self
        agePicker.delegate = self
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return weightData.count
        }
        else{
            return ageData.count
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0{
            return weightData[row]
        }
        else{
            return ageData[row]
        }
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            defaults.setObject(weightData[row], forKey: "weight")
        }
        else{
            defaults.setObject(ageData[row], forKey: "age")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}