//
//  NavController.swift
//  Tute12
//
//  Created by Muhsana Chowdhury  on 20/1/21.
//

import UIKit
import EventKit

class NavController: UINavigationController {
    
    let eventStore = EKEventStore()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch EKEventStore.authorizationStatus(for: EKEntityType.event) {
                case .authorized:
                    //insertEvent(eventStore)
                    print("Access Granted")
                case .denied:
                    print("Access denied")
                case .notDetermined:
                    // If the status is not yet determined the user is prompted to deny or grant access using the requestAccessToEntityType(entityType:completion) method.
                    eventStore.requestAccess(to: EKEntityType.event, completion: {(granted, error) in
                        if granted {
                            //self.insertEvent(self.eventStore)
                            print("Access Granted")
                        } else {
                            print("Access denied")
                        }
                    })
                default:
                    print("Case Default")
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
