//
//  ViewController.swift
//  DailyScrum
//
//  Created by Ben Moore on 2/20/20.
//  Copyright © 2020 Ben Moore. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showMembers() {
        if (memberCount < members.count){
            orderButton.setTitle(members[memberCount], for: .normal)
        } else {
            orderButton.setTitle("Order Complete", for: .normal)
        }
    }
    
    @IBAction func randomizeClick(_ sender: Any) {
        members = [String]()
        if (beatriceSwitch.isOn) {
            members.append("Beatrice")
        }
        if (benSwitch.isOn) {
            members.append("Ben")
        }
        if (gregSwitch.isOn) {
            members.append("Greg")
        }
        if (jacobSwitch.isOn) {
            members.append("Jacob")
        }
        if (mitchellSwitch.isOn) {
            members.append("Mitchell")
        }
        if (viktorSwitch.isOn) {
            members.append("Viktor")
        }
        if (willSwitch.isOn) {
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
    }
}

