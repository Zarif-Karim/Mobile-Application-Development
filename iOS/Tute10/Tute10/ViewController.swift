//
//  ViewController.swift
//  Tute10
//
//  Created by Zarif Karim  on 11/1/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData:[String] = ["Ham and pineapple", "Supreme", "Seafood"," Italian", "Meat lovers"];
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1; // one column
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.picker.dataSource = self
        self.picker.delegate = self
    }

    @IBAction func submit(_ sender: Any) {
        let alert = UIAlertController(title: "Pizza Selection", message: "You have select \(pickerData[picker.selectedRow(inComponent: 0)])", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        alert.present(alert, animated: true, completion: nil)
    }
    
}

