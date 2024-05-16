//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVAudioPlayer!
    let eggTimes = ["Soft": 300, "Medium": 500,"Hard": 750]
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    
    @IBOutlet weak var lable: UILabel!
    var lableDone:UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        lable.text = hardness
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @objc func updateTimer(){
        if secondsPassed < totalTime {
                secondsPassed += 1
                
                let newProgress = Float(secondsPassed) / Float(totalTime)
                
                UIView.animate(withDuration: 1.0) {
                    self.progressBar.setProgress(newProgress, animated: true)
                }
            } else  {
                timer.invalidate()
                lable.text = "DONE!"
                playSound(soundName: "alarm_sound")
            }

    }
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}


