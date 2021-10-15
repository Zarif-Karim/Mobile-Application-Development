//
//  DayExViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 30/1/21.
//

import UIKit
import CoreData

class DayExViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tVdEx: UITableView!
    
    let db = DBM()
    var day: Day?
    var tvExContent: [Exercise] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tVdEx.delegate = self
        self.tVdEx.dataSource = self
        
        tvExContent.removeAll()
        for wDB in (day?.exercises)! {
            tvExContent.append((wDB as! WorkoutDB).forEx!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tvExContent.removeAll()
        for wDB in (day?.exercises)! {
            tvExContent.append((wDB as! WorkoutDB).forEx!)
        }
        tVdEx.reloadData()
    }
    //setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvExContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dExTCell", for: indexPath) as! ProgramsTableViewCell
        cell.dExTCellEx!.text = tvExContent[indexPath.row].exName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete"){ (action, view, completionHandler) in
            var index = -1
            for wDB in (self.day?.exercises)! {
                index += 1
                if index == indexPath.row {
                    self.db.deleteWorkoutDB(workoutDB: wDB as! WorkoutDB)
                    break
                }
            }
            
            self.tvExContent.removeAll()
            for wDB in (self.day?.exercises)! {
                self.tvExContent.append((wDB as! WorkoutDB).forEx!)
            }
            self.tVdEx.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    @IBAction func addEx(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextPage = segue.destination as? ExerciseTableViewController {
            nextPage.day = self.day
            nextPage.fromSender = "DayExViewController"
        }
    }

}
