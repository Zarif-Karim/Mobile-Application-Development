//
//  2ndViewController.swift
//  Tute11CD
//
//  Created by Muhsana Chowdhury  on 18/1/21.
//

import UIKit
import CoreData

class _ndViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tView: UITableView!
    
    var content:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tView.delegate = self
        self.tView.dataSource = self

        // Do any additional setup after loading the view.
        let db = DBM()
        content = db.retrieveRows()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TableViewCell
    cell.name!.text = (content[indexPath.row].value(forKeyPath: "name") as? String)!
    cell.price!.text = String(format: "%.2f", (content[indexPath.row].value(forKeyPath: "price") as? Double)!)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            
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
