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
        } else {
            orderButton.setTitle("Order Complete", for: .normal)
            if soundOn {
                let speechString: AVSpeechUtterance = AVSpeechUtterance(string: "Order complete. Thanks")
                speechString.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
                speechString.voice = AVSpeechSynthesisVoice(language: "en-US")
                speechSynthesizer.speak(speechString)
            }
        }
    }
    
    @IBAction func randomizeClick(_ sender: Any) {
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

