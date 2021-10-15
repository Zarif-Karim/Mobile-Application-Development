//
//  LogsViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 28/1/21.
//

import UIKit

class LogsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var logsTable: UITableView!
    var contents:[String] = ["Logs","Manage Categories", "Manage Exercises", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.logsTable.dataSource = self
        self.logsTable.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

     let cell = tableView.dequeueReusableCell(withIdentifier: "LogsTVCell", for: indexPath) as! LogsMainTableViewCell
        cell.lgslblMain!.text = (contents[indexPath.row])
     
         return cell
     }
    
    //go to appropriate pages based on table selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var goScreen:UIViewController?
        var nav: Bool = true;
        switch contents[indexPath.row] {
        case "Logs":
            goScreen = (storyboard?.instantiateViewController(identifier: "LogsDisplayTable") as? LogDisTableViewController)!
        case "Manage Categories":
            goScreen = (storyboard?.instantiateViewController(identifier: "ManageCategory") as? ManageCategoryViewController)!
        case "Manage Exercises":
            goScreen = (storyboard?.instantiateViewController(identifier: "ManageExercise") as? ManageExerciseViewController)!
        default:
            nav = false;
        }
        if nav {
            self.show(goScreen!, sender: self)
        }
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
