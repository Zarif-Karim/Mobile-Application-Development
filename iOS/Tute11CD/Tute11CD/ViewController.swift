//
//  ViewController.swift
//  Tute11CD
//
//  Created by Muhsana Chowdhury  on 18/1/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addRecord(_ sender: Any) {
        let db = DBM()
        db.addRow(name: name.text!, price: price.text!)
    }
    
}

