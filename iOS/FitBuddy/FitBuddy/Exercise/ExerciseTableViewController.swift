//
//  ExerciseTableViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 29/1/21.
//

import UIKit
import CoreData

class ExerciseTableViewController: UITableViewController {

    var category: Category?
    var day: Day?
    var fromSender: String?
    var content:[NSManagedObject] = []
    let db = DBM()
    var navToDes: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem
        if fromSender == "DayExViewController" {
            category = day?.dayCat
        }
        
        for x in category!.catEx! {
            content.append((x as? NSManagedObject)!)
        }
        
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        fromSender = nil
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return content.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exMainCell", for: indexPath) as! ExerciseTableViewCell
        
        cell.exLableMain!.text = content[indexPath.row].value(forKey: "exName") as! String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navToDes = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "exMainCell") as! ExerciseTableViewCell
        cell.exExtoDes.sendActions(for: .touchUpInside)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextPage = segue.destination as? ExDescriptionViewController {
            nextPage.exercise = content[navToDes!] as? Exercise
            nextPage.day = self.day
        }
    }
    

}
