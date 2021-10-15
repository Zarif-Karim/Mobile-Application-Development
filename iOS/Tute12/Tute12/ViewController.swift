//
//  ViewController.swift
//  Tute12
//
//  Created by Muhsana Chowdhury  on 20/1/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var st: UIStepper!
    var audioPlayer: AVAudioPlayer!
    let p = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if p.is {
            
        }
    }

    @IBAction func play(_ sender: Any) {
        let path = Bundle.main.path(forResource: "audio.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            //some error
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        audioPlayer.pause()
    }
    
    @IBAction func stop(_ sender: Any) {
        audioPlayer.stop()
    }
}

