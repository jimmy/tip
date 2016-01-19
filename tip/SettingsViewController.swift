//
//  SettingsViewController.swift
//  tip
//
//  Created by Jimmy Kittiyachavalit on 1/18/16.
//  Copyright © 2016 Jimmy Kittiyachavalit. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let defaultTipIndexKey = "defaultTipIndex"
    let currencyCodeKey = "currencyCode"
    let currencyPickerData = NSLocale.ISOCurrencyCodes()

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey(defaultTipIndexKey)
        defaultTipControl.selectedSegmentIndex = tipIndex

        currencyPicker.dataSource = self
        currencyPicker.delegate = self

        var currencyCode = "USD"
        if defaults.objectForKey(currencyCodeKey) != nil {
            currencyCode = defaults.objectForKey(currencyCodeKey) as! String
        }

        var currencyPickerIndex = 0
        if currencyPickerData.indexOf(currencyCode) != nil {
            currencyPickerIndex = currencyPickerData.indexOf(currencyCode)!
        }
        currencyPicker.selectRow(currencyPickerIndex, inComponent: 0, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onValueChange(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: defaultTipIndexKey)
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyPickerData.count
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyPickerData[row]
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(currencyPickerData[row], forKey: currencyCodeKey)
    }
}
