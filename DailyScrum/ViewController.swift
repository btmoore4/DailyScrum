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
    @IBOutlet weak var mitchellSwitch: UISwitch!
    @IBOutlet weak var viktorSwitch: UISwitch!
    @IBOutlet weak var willSwitch: UISwitch!
    
    // Control Buttons
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var randomizeButton: UIButton!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!

    // Control Variables
    var members: [String] = [String]()
    var memberTimes: [Date] = [Date]()
    var memberCount: Int = 0
    var soundOn: Bool = false
    
    // Sound Constants
    let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    let systemSoundID: SystemSoundID = 1016
    
    // Progress Bar Constants
    let progressBarTickRate: Int = 4 // Number of ticks in a second
    let progressBarDuration: Int = 180 // Number in seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isIdleTimerDisabled = true
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch let error as NSError {
            print("Error: Could not setup Audio Session: \(error), \(error.userInfo)")
        }
        Timer.scheduledTimer(withTimeInterval: 1.0 / Double(progressBarTickRate), repeats: true) { timer in
            self.updateProgressBar()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let teamViewController = segue.destination as! TeamViewController
        teamViewController.members = members
    }
    
    func initProgressBar() {
        progressBar.progress = 0
        progressBar.isHidden = false //Un-Hiding ProgressBar
    }
    
    func updateProgressBar() {
        if progressBar.progress < 1.0 {
            progressBar.progress += Float(1.0 / Double(progressBarTickRate * progressBarDuration))
        }
    }
    
    func stopProgressBar() {
        progressBar.isHidden = true //Re-Hiding ProgressBar
    }
    
    func showMembers() {
        memberTimes.append(NSDate.now)
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
            let timeDifference = Int(memberTimes[memberTimes.count - 1].timeIntervalSince(memberTimes[0]))
            orderButton.setTitle("Time: \(timeDifference) seconds", for: .normal)
            if soundOn {
                let speechString: AVSpeechUtterance = AVSpeechUtterance(string: "scrum over. \(timeDifference) seconds")
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
        memberTimes = [Date]([NSDate.now])
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
