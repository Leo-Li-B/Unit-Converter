//
//  ViewController.swift
//  Unit Converter
//
//  Created by Bo Ning Li on 1/21/19.
//  Copyright © 2019 Langara College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var temperatureRange: TemperatureRange!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperaturePicker: UIPickerView!
    @IBOutlet weak var switchController: UISegmentedControl!
    
    let unitConverter = UnitConverter()
    
    let userDefaultsLastDegreesKey = "defaultChosenDegrees"
    let userDefaultsLastRowKey = "defaultCelciusPickerRow"
    
    @IBAction func switchActionView(_ sender: UISegmentedControl) {
        switch switchController.selectedSegmentIndex{
        case 0:
            temperaturePicker.reloadAllComponents()
            pickerView(temperaturePicker, didSelectRow:initalPickerRow(), inComponent: 0)
            savedSelectedDegrees(degrees: 0)
        case 1:
            temperaturePicker.reloadAllComponents()
            pickerView(temperaturePicker, didSelectRow:initalPickerRow(), inComponent: 0)
            savedSelectedDegrees(degrees: 1)

        default:
            break;
        }
        
//       UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "chosenDegrees")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switchController.selectedSegmentIndex = chosenDegrees()
        
        temperaturePicker.delegate = self
        let defaultPickerRow = initalPickerRow()
        temperaturePicker.selectRow(defaultPickerRow, inComponent: 0, animated: true)
        pickerView(temperaturePicker, didSelectRow:defaultPickerRow,inComponent: 0)
        }
    
    func initalPickerRow() -> Int {
        if let savedRow = UserDefaults.standard.object(forKey:userDefaultsLastRowKey) as? Int{
            return savedRow
        }
        return temperaturePicker.numberOfRows(inComponent: 0) / 2
    }
    func chosenDegrees() -> Int{
        if let savedDegrees = UserDefaults.standard.object(forKey: userDefaultsLastDegreesKey) as? Int{
            return savedDegrees
            
        }
        return 0
    }
    
        func saveSelectedRow(row:Int) {
            let defaults = UserDefaults.standard
            defaults.set(row, forKey: userDefaultsLastRowKey)
            defaults.synchronize()
        }
    func savedSelectedDegrees(degrees:Int) {
        let defaults = UserDefaults.standard
        defaults.set(degrees, forKey: userDefaultsLastDegreesKey)
        defaults.synchronize()
    }
    

    
    func displayConvertedTemperatureForRow(row:Int){
        let celciusValue = temperatureRange.value[row]
         temperatureLabel.text="\(unitConverter.degreesFarenheit(degreesCelcius: celciusValue)) °F"
    }
        
    }





extension ViewController: UIPickerViewDelegate{

    
    //these are delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if switchController.selectedSegmentIndex == 0{
        return "\(temperatureRange.value[row]) °C"
        } else {
            return "\(temperatureRange.value[row]) °F"
        }
        //return a string, while row is an int
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("User tapped row:\(row)")
        displayConvertedTemperatureForRow(row: row)
        saveSelectedRow(row: row)
        let celciusValue = Float(temperatureRange.value[row])
        if switchController.selectedSegmentIndex == 0{
            temperatureLabel.text = "\(unitConverter.degreesFarenheit(degreesCelcius: Int(celciusValue)))°F"
        } else {
            temperatureLabel.text = "\(unitConverter.degreesCelcius(degreesFarenheit: Int(celciusValue)))°C"
        }
    }
    

    
    
}


