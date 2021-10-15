//
//  AddProgramViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 29/1/21.
//

import UIKit
import CoreData

class AddProgramViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    static var pID: Int = 0
    
    let db = DBM()
    var dpw: Int = 1
    var days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var cat:[NSManagedObject] = []
    var tVContent:[NSManagedObject] = []
    //var dbDays:[NSManagedObject] = []
    @IBOutlet weak var tVdays: UITableView!
    @IBOutlet weak var dayStepper: UIStepper!
    @IBOutlet weak var stepperLable: UILabel!
    @IBOutlet weak var pName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tVdays.delegate = self
        self.tVdays.dataSource = self
        
        self.cat = db.retrieveRows(table: "Category")
        self.tVContent = self.db.retrieveDaysPredicate(predicate: "dayP == null")
        
        self.navigationItem.hidesBackButton = true
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //setup stepper
    @IBAction func stepDay(_ sender: Any) {
        dpw = Int.init(dayStepper.value)
        stepperLable.text = String.init(dpw)
        tVdays.reloadData()
    }
    
    //setup picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.accessibilityLabel == "cat" {
            return cat.count
        } else {
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.accessibilityLabel == "cat" {
            return (cat[row] as! Category).catName
        } else {
            return days[row]
        }
    }
    
    //setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dpw
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "createTableCell", for: indexPath) as! ProgramsTableViewCell
        
        let day = cell.createProgramDay!
        let category = cell.createProgramCategory!
        
        if (indexPath.row) > tVContent.count - 1 {
            day.text = "Select Day"
            category.text = "Select Category"
        } else {
            let d = tVContent[indexPath.row] as! Day
            day.text = d.dayName
            category.text = (d.dayCat!).catName
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "addtoday", sender: self)
        //define alert
        let alert = UIAlertController(title: "Add Day & Category", message: "Day:\n\n\n\n\n\n\nCategory:\n\n\n\n\n", preferredStyle: .alert)
        
        //populate textfiels with details of clicked exercise
        let pickDay = UIPickerView(frame: CGRect(x: 5, y: 55, width: 250, height: 100))
        pickDay.accessibilityLabel = "days"
        pickDay.delegate = self
        pickDay.dataSource = self
        alert.view.addSubview(pickDay)
        
        let pickCat = UIPickerView(frame: CGRect(x: 5, y: 165, width: 250, height: 100))
        pickCat.accessibilityLabel = "cat"
        pickCat.dataSource = self
        pickCat.delegate  = self
        alert.view.addSubview(pickCat)
        
        //add buttons
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if (indexPath.row) <= tVContent.count - 1 {
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                self.db.deleteRowDay(row: self.tVContent[indexPath.row] as! Day)
                
                //reload table data
                self.tVContent = self.db.retrieveDaysPredicate(predicate: "dayP == null")
                self.tVdays.reloadData()
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            
            //add day to database
            let n = self.days[pickDay.selectedRow(inComponent: 0)]
            let c = self.cat[pickCat.selectedRow(inComponent: 0)] as! Category
            
            if (indexPath.row) > self.tVContent.count - 1 {
                self.db.addRowDay(name: n, category: c)
            } else {
                let d = self.tVContent[indexPath.row] as! Day
                self.db.updateRowDay(row: d, name: n, category: c)
            }
            
            //reload data
            self.tVContent = self.db.retrieveDaysPredicate(predicate: "dayP == null")
            self.tVdays.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func addProgram(_ sender: Any) {
        
        var daysAdd: [Day] = []
        for x in 0...dpw - 1 {
            daysAdd.append(tVContent[x] as! Day)
        }
        
        self.db.addRowProgram(id: String.init(AddProgramViewController.pID+1), name: pName.text!, dpw: String.init(dpw), pDays: daysAdd)
        
        AddProgramViewController.pID += 1
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func discardProgram(_ sender: Any) {
        while tVContent.count > 0 {
            self.db.deleteRowDay(row: tVContent[0] as! Day)
            tVContent.remove(at: 0)
        }
        //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
