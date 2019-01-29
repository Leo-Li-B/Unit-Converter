//
//  TemperatureRange.swift
//  Unit Converter
//
//  Created by Bo Ning Li on 1/21/19.
//  Copyright © 2019 Langara College. All rights reserved.
//

import UIKit
import Foundation

class TemperatureRange:NSObject, UIPickerViewDataSource{
    
    let value = [Int](-100...100).map { $0 }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return value.count
    }
    
}
