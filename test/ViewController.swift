//
//  ViewController.swift
//  test
//
//  Created by Sterling Lutes on 7/6/16.
//  Copyright © 2016 Sterling Lutes. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var myPicker: UIPickerView?

    override func viewDidLoad() {
        
        let pickerTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapPicker))
        myPicker?.addGestureRecognizer(pickerTap)
        pickerTap.delegate = self
        
        super.viewDidLoad()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       return String(row)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func tapPicker() {
        print("Tapped")
        myPicker?.delegate?.pickerView!(myPicker!, didSelectRow: 0, inComponent: 0);
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //Calculate value of digits
        var total : Int = pickerView.selectedRow(inComponent: 3)
        total += pickerView.selectedRow(inComponent: 0) * 1000
        total += pickerView.selectedRow(inComponent: 1) * 100
        total += pickerView.selectedRow(inComponent: 2) * 10
        
        //Disable numbers above Maxiumum value
        let max = 2589
        if (total > max) {
            total = max
            let hundreds : Int = max - (Int(max/1000)*1000)
            let tens : Int     = max - (Int(max/1000)*1000) - (Int(hundreds/100)*100)
            pickerView.selectRow(Int(max/1000), inComponent: 0, animated: true)
            pickerView.selectRow(Int(hundreds/100), inComponent: 1, animated: true)
            pickerView.selectRow(Int(tens/10), inComponent: 2, animated: true)
            pickerView.selectRow(tens%10, inComponent: 3, animated: true)
            print(String(format:"Maximum Value of %i Exceeded",max))
        }
        print(String(format:"Value: %i",total))
    }
}

