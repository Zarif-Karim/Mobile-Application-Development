//
//  ViewController.swift
//  Tute9
//
//  Created by Muhsana Chowdhury  on 11/1/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var gender: UISwitch!
    @IBOutlet weak var seg: UISegmentedControl!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gSwitch: UILabel!
    @IBOutlet weak var gSegment: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var navb1: UILabel!
    @IBAction func navB(_ sender: Any) {
        navb1.text = "Home"
    }
    @IBAction func Show(_ sender: Any) {
        var gen:String
        if gender.isOn {
            gen = "Female"
        } else {
            gen = "Male"
        }
        
        var sGen:String
        if seg.selectedSegmentIndex == 0 {
            sGen = "Male"
        } else {
            sGen = "Female"
        }
        
        name.text = "Name: " + NameField.text!
        gSwitch.text! += gen
        gSegment.text! +=  sGen
        
    }
    
}

