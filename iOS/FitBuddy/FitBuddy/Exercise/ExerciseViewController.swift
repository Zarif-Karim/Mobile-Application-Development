//
//  ExerciseViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 20/1/21.
//

import UIKit
import CoreData

class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableV: UITableView!
    
    let db:DBM = DBM()
    var content:[NSManagedObject] = []
    var navObjIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableV.delegate = self
        self.tableV.dataSource = self
        
        content = db.retrieveRows(table: "Category")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.content = db.retrieveRows(table: "Category")
        self.tableV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ExerciseTableViewCell
    cell.tCell!.text = (content[indexPath.row].value(forKeyPath: "catName") as? String)!
    //cell.price!.text = String(format: "%.2f", (content[indexPath.row].value(forKeyPath: "price") as? Double)!)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navObjIndex = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ExerciseTableViewCell
        cell.exCatToEx!.sendActions(for: .touchUpInside)
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //var goScreen:UIViewController?
        //goScreen = (storyboard?.instantiateViewController(identifier: "ExTableVC") as? ExerciseTableViewController)!
        //self.show(goScreen!, sender: self)
            
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextPage = segue.destination as? ExerciseTableViewController {
            nextPage.category = content[navObjIndex!] as? Category
        }
    }
    /*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
