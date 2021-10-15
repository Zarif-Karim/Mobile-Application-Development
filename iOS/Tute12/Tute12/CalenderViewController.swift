//
//  CalenderViewController.swift
//  Tute12
//
//  Created by Muhsana Chowdhury  on 20/1/21.
//

import UIKit
import EventKit

class CalenderViewController: UIViewController {

    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            event.title = "New Meeting"
            event.startDate = startDate
            event.endDate = endDate
            // Save Event in Calendar
            do {
                try store.save(event, span: .thisEvent)
            } catch {
                print("An error occured")
            }
        }

    @IBAction func crate(_ sender: Any) {
        insertEvent(eventStore)
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
