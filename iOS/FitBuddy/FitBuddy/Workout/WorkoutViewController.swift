//
//  WorkoutViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 31/1/21.
//

import UIKit
import CoreData

class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let db = DBM()

    @IBOutlet weak var dow: UILabel!
    @IBOutlet weak var pNameLable: UILabel!
    @IBOutlet weak var pCatTitle: UILabel!
    @IBOutlet weak var pCatLable: UILabel!
    @IBOutlet weak var pExTableView: UITableView!
    @IBOutlet weak var strtBtn: UIButton!
    
    var program: Program?
    var pDay : Day?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dow.text = getDayofWeek()
        program = ProgramViewController.activeProgram
 
        pExTableView.delegate = self
        pExTableView.dataSource = self
       
        //set up page
        setupPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        program = ProgramViewController.activeProgram
        setupPage()
    }
    
    //get day of the week from Date
    func getDayofWeek() -> String {
        let date = Date()
        let dF = DateFormatter()
        dF.dateFormat = "EEEE"
        return dF.string(from: date)
    }
    
    func setupPage() {
        if program != nil {
            pNameLable.text = program?.pName
            //get program day
            pDay = nil
            for d in (program?.pDays)! {
                let dy = (d as! Day)
                if dy.dayName == dow.text {
                    pDay = dy
                    break
                }
            }
        } else {
            pNameLable.text = "No Active Program"
        }
        
        pCatTitle.isHidden = true
        pCatLable.isHidden = true
        pExTableView.isHidden = true
        strtBtn.isEnabled = false
        strtBtn.backgroundColor = UIColor.systemGray
        strtBtn.setTitle("No Workout", for: .disabled)
        
        if pDay != nil {
            pCatLable.text = pDay?.dayCat?.catName
            pCatTitle.isHidden = false
            pCatLable.isHidden = false
            pExTableView.isHidden = false
            strtBtn.isEnabled = true
            strtBtn.backgroundColor = UIColor.systemGreen
            strtBtn.setTitle("Start Workout", for: .normal)
        }
        
        pExTableView.reloadData()
    }
        
    //setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pDay?.exercises?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutExCell", for: indexPath) as! WorkoutTableViewCell
        
        let ex = (self.pDay?.exercises?.allObjects[indexPath.row])! as! WorkoutDB
        cell.exName!.text = ex.forEx?.exName
        cell.rNo!.text = String.init(ex.reps)
        cell.sNo!.text = String.init(ex.sets)
        cell.wNo!.text = String.init(ex.weight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ex = (self.pDay?.exercises?.allObjects[indexPath.row])! as! WorkoutDB
        
        let alert = UIAlertController(title: ex.forEx?.exName, message: "For Weight: Enter 0 for body weight.", preferredStyle: .alert)
        
        //populate textfiels with details of clicked exercise
        alert.addTextField(configurationHandler: {textField in textField.text = String.init(ex.reps) })
        alert.addTextField(configurationHandler: {textField in textField.text = String.init(ex.sets) })
        alert.addTextField(configurationHandler: {textField in textField.text = String.init(ex.weight) })
        
        //add buttons
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { action in
            
            //update
            self.db.updateWorkoutDbRSW(
                row: (self.pDay?.exercises?.allObjects[indexPath.row])! as! WorkoutDB,
                reps: alert.textFields![0].text!,
                sets: alert.textFields![1].text!,
                weight: alert.textFields![2].text!
            )
            //reload
            self.pExTableView.reloadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextPage = segue.destination as? InProgressWorkoutViewController {
            nextPage.day = pDay
        }
    }

}
