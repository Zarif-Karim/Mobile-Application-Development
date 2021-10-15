//
//  DBM.swift
//  Tute11CD
//
//  Created by Muhsana Chowdhury  on 18/1/21.
//

import UIKit
import CoreData

class DBM: NSObject {

    var products: [NSManagedObject] = []
    
    func addRow ( name:String, price:String) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Pizza", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(name, forKey: "name")
        product.setValue(Double.init(price), forKey: "price")
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func retrieveRows()-> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return [NSManagedObject]()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Pizza")
        
        do {
            products = try managedContext.fetch(fetchRequest)
            //show notification
        } catch _ as NSError {
            // show notification
        }
        
        return products
    }
    
    
    
}
