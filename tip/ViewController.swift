//
//  ViewController.swift
//  tip
//
//  Created by Jimmy Kittiyachavalit on 1/18/16.
//  Copyright © 2016 Jimmy Kittiyachavalit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
     let defaultTipIndexKey = "defaultTipIndex"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey(defaultTipIndexKey)
        tipControl.selectedSegmentIndex = tipIndex

        billField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipAmount = 0.0
        var totalAmount = 0.0
        let tipPercentages = [0.15, 0.18, 0.20, 0.25]
        let tipPercent = tipPercentages[tipControl.selectedSegmentIndex]
        
        if let billText = billField.text {
            if let billAmount = Double(billText) {
                tipAmount = billAmount * tipPercent
                totalAmount = billAmount + tipAmount
            }
        }
        
        tipLabel.text = String(format: "$%.2f", tipAmount)
        totalLabel.text = String(format: "$%.2f", totalAmount)
    }
    
    @IBAction func onTap(sender: AnyObject) {
       //view.endEditing(true)
    }
}