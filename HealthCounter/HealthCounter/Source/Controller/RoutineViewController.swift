//
//  RoutineViewController.swift
//  HealthCounter
//
//  Created by Wi on 07/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class RoutineViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        
    }
}
