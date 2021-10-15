//
//  InProgressWorkoutViewController.swift
//  FitBuddy
//
//  Created by Muhsana Chowdhury  on 31/1/21.
//

import UIKit
import CoreData
import MessageUI

class InProgressWorkoutViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {

    let db = DBM()
    var seconds = 30
    var timer = Timer()
    var day : Day?
    var index = 0
    
    var image : UIImagePickerController!
    @IBOutlet weak var exName: UILabel!
    @IBOutlet weak var rep: UILabel!
    @IBOutlet weak var set: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var restTimer: UILabel!
    @IBOutlet weak var finishBtn: UIButton!
    @IBOutlet weak var sendSmsBtn: UIButton!
    @IBOutlet weak var selectImg: UIButton!
    
    var exercises: [WorkoutDB] = []
    @IBOutlet weak var imgBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for e in (day?.exercises)! {
            exercises.append(e as! WorkoutDB)
        }
        
        setupPage()
    }
    override func viewDidAppear(_ animated: Bool) {
        exercises.removeAll()
        for e in (day?.exercises)! {
            exercises.append(e as! WorkoutDB)
        }
        
        if finishBtn.currentTitle != "Finish Workout" {
            imgBtn.isHidden = true
            sendSmsBtn.isHidden = true
            selectImg.isHidden = true
        }
        setupPage()
    }
    @IBAction func restBtn(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(InProgressWorkoutViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @IBAction func finishEx(_ sender: Any) {
        if index < exercises.count - 1{
            index += 1
            setupPage()
        } else if index == exercises.count - 1 {
            finishBtn.setTitle("Finish Workout", for: .normal)
            finishBtn.backgroundColor = UIColor.blue
            index += 1
            imgBtn.isHidden = false
            sendSmsBtn.isHidden = false
            selectImg.isHidden = false
        } else {
            finishBtn.setTitle("Finish Exercise", for: .normal)
            finishBtn.backgroundColor = UIColor.systemGreen
            index = 0
            
            let date = getDate()
            let prog = (day?.dayP?.pName)!
            let d = day?.dayName
            let c = day?.dayCat?.catName
            db.addRowLog(date: date, program: prog, day: d!, category: c!)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResult.cancelled.rawValue:
            print("Message was cancelled")
            controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.failed.rawValue:
                print("Message failed")
                controller.dismiss(animated: true, completion: nil)
        case MessageComposeResult.sent.rawValue:
            print("Message was sent")
            controller.dismiss(animated: false, completion: nil)
        default:
            controller.dismiss(animated: true, completion: nil)
            break
        }
    }
    
    @objc func updateTimer() {
        seconds -= 1     //This will decrement(count down)the seconds.
        restTimer.text = "\(seconds)" //This will update the label.
        if seconds == 0 {
            timer.invalidate()
            seconds = 30
            restTimer.text = "\(seconds)"
        }
    }
    
    func setupPage() {
        var index = self.index
        if index >= exercises.count {
            index = exercises.count - 1
        }
        exName.text = exercises[index].forEx?.exName
        rep.text = "\(exercises[index].reps)"
        set.text = "\(exercises[index].sets)"
        weight.text = "\(exercises[index].weight)"
    }
    
    func getDate() -> String {
        let date = Date()
        let dF = DateFormatter()
        dF.dateFormat = "dd/MM/y"
        return dF.string(from: date)
    }
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func imgBtn(_ sender: Any) {
        image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .camera
        // if no camera
        present(image, animated: true, completion: nil)
        
    }
    
    @IBAction func selectImage(_ sender: Any) {
        if
            UIImagePickerController.isSourceTypeAvailable (UIImagePickerController.SourceType.photoLibrary) {
        var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType
            = UIImagePickerController.SourceType.photoLibrary ;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func sendSms(_ sender: Any) {
        //sms
        if MFMessageComposeViewController.canSendText() {
            var messageVC = MFMessageComposeViewController()
            messageVC.body = "You have finished a workout"
            messageVC.recipients = ["0424582622"]
            messageVC.messageComposeDelegate = self
            self.present(messageVC, animated: false, completion: nil)
        }
    }
    
    @IBAction func closeView(_ sender: Any) {
        imgView.isHidden = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = img
            imgView.isHidden = false
            dismiss(animated: true, completion: nil)
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
