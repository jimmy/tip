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
    @IBOutlet weak var localePicker: UIPickerView!
    @IBOutlet weak var currencyButton: UIButton!
    @IBOutlet weak var localeButton: UIButton!

    let defaults = NSUserDefaults.standardUserDefaults()
    let defaultTipIndexKey = "defaultTipIndex"
    let currencyCodeKey = "currencyCode"
    let currencyPickerData = NSLocale.ISOCurrencyCodes()
    let localeKey = "localeKey"
    let localePickerData = SettingsViewController.localeIdentifiersSortedByDisplayName()

    override func viewDidLoad() {
        super.viewDidLoad()
        let tipIndex = defaults.integerForKey(defaultTipIndexKey)
        defaultTipControl.selectedSegmentIndex = tipIndex

        currencyPicker.dataSource = self
        currencyPicker.delegate = self

        localePicker.dataSource = self
        localePicker.delegate = self

        var locale = NSLocale.currentLocale()
        if defaults.objectForKey(localeKey) != nil {
            let localeIdentifier = defaults.objectForKey(localeKey) as! String
            locale = NSLocale(localeIdentifier: localeIdentifier)
        }

        var localePickerIndex = 0
        if localePickerData.indexOf(locale.localeIdentifier) != nil {
            localePickerIndex = localePickerData.indexOf(locale.localeIdentifier)!
        }
        localePicker.selectRow(localePickerIndex, inComponent: 0, animated: false)

        // Default to currency of current locale
        var currencyCode = NSLocale.currentLocale().objectForKey(NSLocaleCurrencyCode) as! String

        // If they saved a specific currency, use that
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
        defaults.setInteger(defaultTipControl.selectedSegmentIndex, forKey: defaultTipIndexKey)
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == currencyPicker {
            return currencyPickerData.count
        } else {
            return localePickerData.count
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == currencyPicker {
            return currencyPickerData[row]
        } else {
            return NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: localePickerData[row])
        }
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == currencyPicker {
            defaults.setObject(currencyPickerData[row], forKey: currencyCodeKey)
        } else {
            defaults.setObject(localePickerData[row], forKey: localeKey)
        }
    }

    @IBAction func onCurrencyButtonTap(sender: AnyObject) {
        let currencyCode = NSLocale.currentLocale().objectForKey(NSLocaleCurrencyCode) as! String
        var index = 0
        if currencyPickerData.indexOf(currencyCode) != nil {
            index = currencyPickerData.indexOf(currencyCode)!
        }
        currencyPicker.selectRow(index, inComponent: 0, animated: false)
        defaults.setObject(currencyCode, forKey: currencyCodeKey)
    }

    @IBAction func onLocaleButtonTap(sender: AnyObject) {
        let localeIdentifier = NSLocale.currentLocale().localeIdentifier
        var index = 0
        if localePickerData.indexOf(localeIdentifier) != nil {
            index = localePickerData.indexOf(localeIdentifier)!
        }
        localePicker.selectRow(index, inComponent: 0, animated: false)
        defaults.setObject(localeIdentifier, forKey: localeKey)
    }

    static func localeIdentifiersSortedByDisplayName() -> [String] {
        return NSLocale.availableLocaleIdentifiers().sort {
            return NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: $0) <
                NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: $1)
        }
    }
}
