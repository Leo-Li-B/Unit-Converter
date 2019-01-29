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
    
//    private let temperatureValues = [Int](-100...100).map { $0 }
    let unitConverter = UnitConverter()
    
    let userDefaultsLastRowKey = "defaultCelciusPickerRow"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        temperaturePicker.dataSource = self
        temperaturePicker.delegate = self
        let defaultPickerRow = initalPickerRow()
        temperaturePicker.selectRow(defaultPickerRow, inComponent: 0, animated: true)
        pickerView(temperaturePicker, didSelectRow:defaultPickerRow,inComponent: 0)
        
        
//        let lowerBound = -100
//        let upperBound = 100
//        for index in lowerBound...upperBound{
//            temperatureValues.append(index)
        }
    
    func initalPickerRow() -> Int {
        if let savedRow = UserDefaults.standard.object(forKey:userDefaultsLastRowKey) as? Int{
            return savedRow
        }
        return temperaturePicker.numberOfRows(inComponent: 0) / 2
    }
    
        func saveSelectedRow(row:Int) {
            let defaults = UserDefaults.standard
            defaults.set(row, forKey: userDefaultsLastRowKey)
            defaults.synchronize()
        }
    
    func displayConvertedTemperatureForRow(row:Int){
        let celciusValue = temperatureRange.value[row]
         temperatureLabel.text="\(unitConverter.degreesFarenheit(degreesCelcius: celciusValue)) °F"
    }
        
    }





extension ViewController: UIPickerViewDelegate{
    //these are Datasource
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return temperatureValues.count
//    }
    
    //these are delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(temperatureRange.value[row]) °C"
        //return a string, while row is an int
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("User tapped row:\(row)")
        displayConvertedTemperatureForRow(row: row)
        saveSelectedRow(row: row)
        
        
//        let degreesCelcius = Float(temperatureValues[row])
//        let degreesFarenheit = 1.8 * degreesCelcius + 32.0
        
//        temperatureLabel.text = "\(Int(degreesFarenheit)) °F"
        
 
        
       
    }
    
}


