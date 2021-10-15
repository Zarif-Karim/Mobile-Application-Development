//
//  ExDescriptionViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 29/1/21.
//

import UIKit

class ExDescriptionViewController: UIViewController {

    
    var exercise: Exercise?
    var day: Day?
    @IBOutlet weak var ExTitle: UILabel!
    @IBOutlet weak var exDescription: UILabel!
    
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var reps: UITextField!
    @IBOutlet weak var repsStepper: UIStepper!
    @IBOutlet weak var sets: UITextField!
    @IBOutlet weak var setsStepper: UIStepper!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var weightStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ExTitle.text = exercise?.exName
        exDescription.text = exercise?.exDescription
        
        
    }
    
    @IBAction func addToW(_ sender: Any) {
        reps.text = "10"
        repsStepper.value = 10.0
        sets.text = "3"
        setsStepper.value = 3.0
        weight.text = "5"
        weightStepper.value = 5.0
        self.addView.isHidden = false
    }
    
    @IBAction func addEx(_ sender: Any) {
        let db = DBM()
        db.addRowWorkoutDB(
            reps: reps.text!,
            sets: sets.text!,
            weight: weight.text!,
            exercise: self.exercise!,
            day: self.day!
        )
        
        self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
    }
    @IBAction func closeAdd(_ sender: Any) {
        addView.isHidden = true
    }
    
    @IBAction func repStepClick(_ sender: Any) {
        reps.text = "\(Int.init(repsStepper.value))"
    }
    @IBAction func setStepClick(_ sender: Any) {
        sets.text = "\(Int.init(setsStepper.value))"
    }
    @IBAction func weightStepClick(_ sender: Any) {
        weight.text = "\(Int.init(weightStepper.value))"
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
