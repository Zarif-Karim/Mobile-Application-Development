//
//  ProgramViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 29/1/21.
//

import UIKit
import CoreData
import EventKit

class ProgramViewController: UIViewController, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    static var activeProgram: Program?
    
    let eventStore = EKEventStore()
    let db = DBM()
    var navObjIndex: Int?
    @IBOutlet weak var tBar: UITabBar!
    @IBOutlet weak var mP: UIView!
    @IBOutlet weak var cP: UIView!
    @IBOutlet weak var myPlanTview: UITableView!
    @IBOutlet weak var cpPNTitle: UILabel!
    @IBOutlet weak var cpTV: UITableView!
    
    var days:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var programTVContent:[NSManagedObject] = []
    var cpDayWorkouts:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tBar.delegate = self
        self.myPlanTview.delegate = self
        self.myPlanTview.dataSource = self
        self.cpTV.delegate = self
        self.cpTV.dataSource = self
        
        self.myPlanTview.accessibilityLabel = "Programs"
        self.cpTV.accessibilityLabel = "DayWorkouts"
        
        programTVContent = db.retrieveRows(table: "Program")
        
        self.tBar.selectedItem = self.tBar.items![0]
        cP.isHidden = true;
        
        switch EKEventStore.authorizationStatus(for: EKEntityType.event) {
                case .authorized:
                    print("Access authorised")
                case .denied:
                    print("Access denied")
                case .notDetermined:
                    // If the status is not yet determined the user is prompted to deny or grant access using the requestAccessToEntityType(entityType:completion) method.
                    eventStore.requestAccess(to: EKEntityType.event, completion: {(granted, error) in
                        if granted {
                            self.insertEvent(self.eventStore)
                        } else {
                            print("Access denied")
                        }
                    })
                default:
                    print("Case Default")
                }
        
        programActivationPageSetup()
    }
    
    @IBAction func calenderEvent(_ sender: Any) {
        insertEvent(eventStore)
    }
    
    func insertEvent(_ store: EKEventStore) {
            // The calendarsForEntityType returns all calendars that supports events
            // The event has a start date of the current time and an end date from the current time
            let startDate = Date()
            // 2 hours = 2 hours x 60 minutes x 60 seconds
            let endDate = startDate.addingTimeInterval(2 * 60 * 60)
            // Create event with a title of "New meeting"
            let event = EKEvent(eventStore: store)
            event.calendar = store.defaultCalendarForNewEvents
            event.title = (cpPNTitle.text)!
            event.startDate = startDate
            event.endDate = endDate
            // Save Event in Calendar
            do {
                try store.save(event, span: .thisEvent)
            } catch {
                print("An error occured")
            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        programTVContent = db.retrieveRows(table: "Program")
        myPlanTview.reloadData()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.title {
        case "My Plans":
            mP.isHidden = false
            cP.isHidden = true
        case "Current Program":
            mP.isHidden = true
            cP.isHidden = false
        default:
            print("Hit Default")
        }
    }
    
    func reloadTableViewData(){
        self.programTVContent = self.db.retrieveRows(table: "Program")
        self.myPlanTview.reloadData()
        self.cpTV.reloadData()
    }
    
    //setup table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.accessibilityLabel == "Programs" {
            return programTVContent.count
        } else {
            return cpDayWorkouts.count
        }
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if tableView.accessibilityLabel == "Programs" {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myPlanTVCell", for: indexPath) as! ProgramsTableViewCell
        
        let pName = programTVContent[indexPath.row].value(forKey: "pName") as! String
        cell.myPlanProgramLable!.text = pName
    
        return cell
    } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cpTCell", for: indexPath) as! ProgramsTableViewCell
        
        let d = cpDayWorkouts[indexPath.row] as? Day
        cell.cpTCellDay!.text = d?.dayName
        cell.cpTCellCategory!.text = d?.dayCat?.catName
    
        return cell
    }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navObjIndex = indexPath.row
        //let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! ExerciseTableViewCell
        //cell.exCatToEx!.sendActions(for: .touchUpInside)
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //var goScreen:UIViewController?
        //goScreen = (storyboard?.instantiateViewController(identifier: "ExTableVC") as? ExerciseTableViewController)!
        //self.show(goScreen!, sender: self)
        if tableView.accessibilityLabel == "Programs" {
            //define alert
            let alert = UIAlertController(title: programTVContent[indexPath.row].value(forKey: "pName") as! String , message: nil, preferredStyle: .alert)
            
            //add buttons
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                self.db.deleteProgram(program: self.programTVContent[indexPath.row] as! Program)
                
                //reload table data
                self.reloadTableViewData()
            }))
            
            
            alert.addAction(UIAlertAction(title: "Set Active", style: .default, handler: { action in
                //set active
                ProgramViewController.activeProgram =  self.programTVContent[indexPath.row] as! Program
                
                //change tab
                self.tBar.selectedItem = self.tBar.items![1]
                self.mP.isHidden = true
                self.cP.isHidden = false
                
                //set up page
                self.programActivationPageSetup()
                
                //reload data
                self.reloadTableViewData()
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cpTCell", for: indexPath) as! ProgramsTableViewCell
            navObjIndex = indexPath.row
            cell.cpTCellBtn.sendActions(for: .touchUpInside)
        }
    }
    
    func programActivationPageSetup() {
        if ProgramViewController.activeProgram != nil {
            self.cpPNTitle.text = ProgramViewController.activeProgram?.pName
            
            //load data for table view
            self.cpDayWorkouts.removeAll()
            for x in (ProgramViewController.activeProgram?.pDays)!
                 {
                self.cpDayWorkouts.append(x as! NSManagedObject)
            }
        } else {
            self.cpPNTitle.text = "No activated Program"
        }
    }
    
    @IBAction func createProgram(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextPage = segue.destination as? DayExViewController {
            nextPage.day = cpDayWorkouts[navObjIndex!] as? Day
        }
    }

}
