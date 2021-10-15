//
//  DBM.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 27/1/21.
//

import UIKit
import CoreData

class DBM: NSObject {
    var products: [NSManagedObject] = []
    
    func addRow ( table:String, columns:[String], value:[String]) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: table, in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        for x in 0...columns.count-1 {
            product.setValue(value[x], forKey: columns[x])
        }
        
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func addRowCategory ( name:String, id:Int16) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(name, forKey: "catName")
        product.setValue(id, forKey: "catID")
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func deleteRowCategory ( row: Category) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var i = 0
        for z in 0...products.count-1 {
            if products[z] == row {
                i = z
                break
            }
        }
        managedContext.delete(row)
        
        do {
            try managedContext.save()
            products.remove(at: i)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
            //let alert = UIAlertController(title: "Delete Category Failed", message: "", preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            print("Delete Category Failed")
            //let v = UIViewController()
            //v.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateRowCategory ( row: Category, id: String, name: String) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        row.catID = Int16.init(id)!
        row.catName = name
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
            print("Update Category Failed")
        }
    }
    
    func addRowExercise ( id:Int16, name:String, description:String, category: Category) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(name, forKey: "exName")
        product.setValue(id, forKey: "exID")
        product.setValue(description, forKey: "exDescription")
        product.setValue(category, forKey: "exCat")
        
        //let ex = Exercise(context: managedContext)
        //ex.exID = id
        //ex.exName = name
        //ex.exDescription = description
        //ex.exCat = category
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func deleteRowExercise ( row: Exercise) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        var i = 0
        for z in 0...products.count-1 {
            if products[z] == row {
                i = z
                break
            }
        }
        managedContext.delete(row)
        
        do {
            try managedContext.save()
            products.remove(at: i)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func updateRowExercise ( row: Exercise, id: String, name: String, description:String, category: Category) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        row.exID = Int16.init(id)!
        row.exName = name
        row.exDescription = description
        row.exCat = category
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func retrieveRows(table:String)-> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return [NSManagedObject]()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: table)
        
        do {
            products = try managedContext.fetch(fetchRequest)
            //show notification
        } catch _ as NSError {
            // show notification
        }
        
        return products
    }
    
    func addRowDay ( name:String, category: Category) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Day", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(name, forKey: "dayName")
        product.setValue(category, forKey: "dayCat")
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func updateRowDay ( row: Day, name: String, category: Category) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        row.dayName = name
        row.dayCat = category
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func retrieveDaysPredicate(predicate:String)-> [NSManagedObject] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return [NSManagedObject]()}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Day")
        let pred = NSPredicate(format: predicate)
        fetchRequest.predicate = pred
        do {
            products = try managedContext.fetch(fetchRequest)
            //show notification
        } catch _ as NSError {
            // show notification
        }
        
        return products
    }
    
    func deleteRowDay ( row: Day) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(row)
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func addRowProgram ( id: String, name:String, dpw: String, pDays: [Day]) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Program", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(id, forKey: "progID")
        product.setValue(name, forKey: "pName")
        product.setValue(dpw, forKey: "dpw")
        
        for d in pDays {
            d.dayP = product as? Program
        }
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func deleteProgram ( program: Program) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        for day in program.pDays! {
            managedContext.delete(day as! Day)
        }
        managedContext.delete(program)
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func addRowWorkoutDB ( reps: String, sets: String, weight: String, exercise: Exercise, day: Day ) {
        //to add workouts row we first have to add WorkoutDB row
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WorkoutDB", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(Int16.init(reps), forKey: "reps")
        product.setValue(Int16.init(sets), forKey: "sets")
        product.setValue(Int16.init(weight), forKey: "weight")
        product.setValue(exercise, forKey: "forEx")
        product.setValue(day, forKey: "day")
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func updateWorkoutDbRSW ( row: WorkoutDB, reps: String, sets: String, weight: String) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        row.reps = Int16.init(reps)!
        row.sets = Int16.init(sets)!
        row.weight = Int16.init(weight)!
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func deleteWorkoutDB ( workoutDB: WorkoutDB) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
            
        managedContext.delete(workoutDB)
        
        do {
            try managedContext.save()
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
    func addRowLog ( date:String, program:String, day: String, category: String) {
        // set the core data to access the pizza entity
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Log", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue(date, forKey: "date")
        product.setValue(program, forKey: "program")
        product.setValue(day, forKey: "day")
        product.setValue(category, forKey: "category")
        
        do {
            try managedContext.save()
            products.append(product)
            //shownotification
        } catch _ as NSError {
            //showerrorNotification
        }
    }
    
}
