//
//  TeamViewController.swift
//  DailyScrum
//
//  Created by Ben Moore on 2/29/20.
//  Copyright © 2020 Ben Moore. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamTable.dataSource = self
        teamTable.delegate = self
        teamTable.tableFooterView = UIView(frame: CGRect.zero)
        teamTable.allowsMultipleSelection = true
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var teamTable: UITableView!
    var members: [String] = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamTableCell", for: indexPath)
        cell.textLabel?.text = members[indexPath.item]
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            members.remove(at: indexPath.row)
            teamTable.beginUpdates()
            teamTable.deleteRows(at: [indexPath], with: .automatic)
            teamTable.endUpdates()
        }
    }
}
