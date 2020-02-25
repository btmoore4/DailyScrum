//
//  ViewController.swift
//  DailyScrum
//
//  Created by Ben Moore on 2/20/20.
//  Copyright © 2020 Ben Moore. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // Scrum Member Switches
    @IBOutlet weak var beatriceSwitch: UISwitch!
    @IBOutlet weak var benSwitch: UISwitch!
    @IBOutlet weak var gregSwitch: UISwitch!
    @IBOutlet weak var jacobSwitch: UISwitch!
    @IBOutlet weak var mitchellSwitch: UISwitch!
    @IBOutlet weak var viktorSwitch: UISwitch!
    @IBOutlet weak var willSwitch: UISwitch!
    
    // Control Buttons
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var members = [String]()
    var memberCount = 0
    var soundOn = false
    var speechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        }
        catch let error as NSError {
            print("Error: Could not set audio category: \(error), \(error.userInfo)")
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setActive to true: \(error), \(error.userInfo)")
        }
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { timer in
            self.updateProgressBar()
        }
    }
    
    func initProgressBar() {
        progressBar.progress = 0
        progressBar.isHidden = false //Un-Hiding ProgressBar
    }
    
    func updateProgressBar() {
        if progressBar.progress < 1.0 {
            progressBar.progress += 0.00138 //At 0.25 Interval this is 180 seconds
        }
    }
    
    func stopProgressBar() {
        progressBar.isHidden = true //Re-Hiding ProgressBar
    }
    
    func showMembers() {
        if (memberCount < members.count){
            orderButton.setTitle(members[memberCount], for: .normal)
            if soundOn {
                let speechString: AVSpeechUtterance = AVSpeechUtterance(string: "\(members[memberCount])")
                speechString.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
                speechString.voice = AVSpeechSynthesisVoice(language: "en-US")
                speechSynthesizer.speak(speechString)
            }
            initProgressBar()
        } else {
            orderButton.setTitle("Order Complete", for: .normal)
            if soundOn {
                let speechString: AVSpeechUtterance = AVSpeechUtterance(string: "Scrum Over")
                speechString.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
                speechString.voice = AVSpeechSynthesisVoice(language: "en-US")
                speechSynthesizer.speak(speechString)
            }
            stopProgressBar()
        }
    }
    
    @IBAction func randomizeClick(_ sender: Any) {
        orderButton.isHidden = false
        members = [String]()
        if beatriceSwitch.isOn {
            members.append("Beatrice")
        }
        if benSwitch.isOn {
            members.append("Ben")
        }
        if gregSwitch.isOn {
            members.append("Greg")
        }
        if jacobSwitch.isOn {
            members.append("Jacob")
        }
        if mitchellSwitch.isOn {
            members.append("Mitchell")
        }
        if viktorSwitch.isOn {
            members.append("Viktor")
        }
        if willSwitch.isOn {
            members.append("Will")
        }
        members.shuffle()
        memberCount = 0
        showMembers()
        initProgressBar()
    }

    @IBAction func orderClick(_ sender: Any) {
        memberCount += 1
        showMembers()
    }
    
    @IBAction func soundToggle(_ sender: Any) {
        soundOn = !soundOn
        if soundOn {
            soundButton.setTitle("Sound On", for: .normal)
        } else {
            soundButton.setTitle("Sound Off", for: .normal)
        }
    }
}

