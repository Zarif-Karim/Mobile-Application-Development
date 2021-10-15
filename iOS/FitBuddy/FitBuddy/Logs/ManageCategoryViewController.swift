//
//  ManageExerciseViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 28/1/21.
//

import UIKit
import CoreData

class ManageCategoryViewController: UIViewController,
    UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var catID: UITextField!
    @IBOutlet weak var catName: UITextField!
    
    let db:DBM = DBM()
    var content:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableV.delegate = self
        self.tableV.dataSource = self
        
        content = db.retrieveRows(table: "Category")
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ExerciseTableViewCell
    cell.tCell!.text = (content[indexPath.row].value(forKeyPath: "catName") as? String)!
    cell.tCellID!.text = String.init(format: "%d", (content[indexPath.row].value(forKeyPath: "catID") as? Int16)!)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //define alert
        let alert = UIAlertController(title: "Update or Delete", message: nil, preferredStyle: .alert)
        
        //populate textfiels with details of clicked exercise
        alert.addTextField(configurationHandler: {textField in textField.text = String.init(self.content[indexPath.row].value(forKey: "catID") as! Int16) })
        alert.addTextField(configurationHandler: {textField in textField.text = (self.content[indexPath.row].value(forKey: "catName") as! String) })
        //alert.addTextField(configurationHandler: {textField in textField.text = (self.contentTable[indexPath.row].value(forKey: "exDescription") as! String) })
        
        //add buttons
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
            self.db.deleteRowCategory(row: self.content[indexPath.row] as! Category)
            
            //reload table data
            self.content = self.db.retrieveRows(table: "Category")
            self.tableV.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            
            let c = self.content[indexPath.row] as! Category
            
            self.db.updateRowCategory(
                row: c,
                id: alert.textFields![0].text!,
                name: alert.textFields![1].text!
            )
            
            //reload data
            self.content = self.db.retrieveRows(table: "Category")
            self.tableV.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
            
    }
    
    @IBAction func add(_ sender: Any) {
        db.addRowCategory(name: catName.text!, id: Int16.init(catID.text!)! )
        content = db.retrieveRows(table: "Category")
        tableV.reloadData()
    }

}
