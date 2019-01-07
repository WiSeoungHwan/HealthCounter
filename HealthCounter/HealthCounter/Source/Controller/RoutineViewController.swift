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
    var routineDatas: [RoutineData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        if UserDefaults.standard.value(forKey: "routineDatas") == nil {
            
        }else{
            guard let userDefaultsData = UserDefaults.standard.value(forKey: "routineDatas") as? [RoutineData] else { return}
            routineDatas = userDefaultsData
            tableView.reloadData()
        }
        tableView.reloadData()
    }
}
extension RoutineViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return routineDatas.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let routineTableVIewCell = Bundle.main.loadNibNamed("RoutineTableViewCell", owner: self, options: nil)?.first as? RoutineTableViewCell else {return UITableViewCell()}
        routineTableVIewCell.routineNameLabel.text = routineDatas[indexPath.section].routineName
        return routineTableVIewCell
    }
    
    
}
extension RoutineViewController: UITableViewDelegate{
    
}
