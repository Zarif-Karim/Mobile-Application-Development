//
//  ManageExerciseViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 28/1/21.
//

import UIKit
import CoreData

class ManageExerciseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let db:DBM = DBM()
    var contentPicker:[NSManagedObject] = []
    var contentTable:[NSManagedObject] = []

    @IBOutlet weak var catPview: UIPickerView!
    @IBOutlet weak var exTview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //for picker view: Category
        self.catPview.dataSource = self
        self.catPview.delegate = self
        contentPicker = db.retrieveRows(table: "Category")
        
        //for table view: Exercises
        self.exTview.dataSource = self
        self.exTview.delegate = self
        contentTable = db.retrieveRows(table: "Exercise")
    }
    
    //picker view setup
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (contentPicker[row].value(forKey: "catName") as! String)
    }
    
    //table view setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mExTCell") as! ExerciseTableViewCell
        cell.mExCID!.text = String.init((contentTable[indexPath.row].value(forKey: "exID") as? Int16)!)
        cell.mExCName!.text = contentTable[indexPath.row].value(forKey: "exName") as? String
        cell.mExCCat!.text = (contentTable[indexPath.row].value(forKey: "exCat") as? Category)!.catName
        return cell
    }
    
    //open popup when clicked to edit or delete exercise
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //define alert
        let alert = UIAlertController(title: "Update or Delete", message: "To update Category: Select category on the picker then update.", preferredStyle: .alert)
        
        //populate textfiels with details of clicked exercise
        alert.addTextField(configurationHandler: {textField in textField.text = String.init(self.contentTable[indexPath.row].value(forKey: "exID") as! Int16) })
        alert.addTextField(configurationHandler: {textField in textField.text = (self.contentTable[indexPath.row].value(forKey: "exName") as! String) })
        alert.addTextField(configurationHandler: {textField in textField.text = (self.contentTable[indexPath.row].value(forKey: "exDescription") as! String) })
        
        //add buttons
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.db.deleteRowExercise(row: self.contentTable[indexPath.row] as! Exercise)
            
            //reload table data
            self.contentTable = self.db.retrieveRows(table: "Exercise")
            self.exTview.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            
            let ex = self.contentTable[indexPath.row] as! Exercise
            
            self.db.updateRowExercise(
                row: ex,
                id: alert.textFields![0].text!,
                name: alert.textFields![1].text!,
                description: alert.textFields![2].text!,
                category: self.contentPicker[self.catPview.selectedRow(inComponent: 0)] as! Category
            )
            
            //reload data
            self.contentTable = self.db.retrieveRows(table: "Exercise")
            self.exTview.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //add button setup
    @IBAction func addEx(_ sender: Any) {
        
        //create alert for insert
        let alert = UIAlertController(title: "Add Exercise", message: "Enter ID, Name, Description. The category is automatically added from the Picker above.", preferredStyle: .alert)
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "ID (e.g. 1)" })
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Name" })
        alert.addTextField(configurationHandler: {textField in textField.placeholder = "Short Description" })
        
        //button handler for saving data
        let add = UIAlertAction(title: "Add", style: .default) { (action) in
            
            self.db.addRowExercise(
                id: Int16.init( alert.textFields![0].text! as String )!,
                name: alert.textFields![1].text!,
                description: alert.textFields![2].text!,
                category: self.contentPicker[self.catPview.selectedRow(inComponent: 0)] as! Category
            )
            
            self.contentTable = self.db.retrieveRows(table: "Exercise")
            self.exTview.reloadData()
        }
        
        alert.addAction(add)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
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
