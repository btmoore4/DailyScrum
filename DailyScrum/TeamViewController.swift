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
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBOutlet weak var teamTable: UITableView!
    var members: [String] = [String](arrayLiteral: "Ben", "Beatrice", "Mitchell")
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamTableCell", for: indexPath)
        cell.textLabel?.text = members[indexPath.item]
        return cell
    }
}
