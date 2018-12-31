//
//  MainViewController.swift
//  HealthCounter
//
//  Created by Wi on 31/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var healthcells: [UITableViewCell] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        tableView.register(UINib(nibName: "CustomHealthCell", bundle: nil), forCellReuseIdentifier: "CustomHealthCell")
        tableView.register(UINib(nibName: "HealthCell", bundle: nil), forCellReuseIdentifier: "HealthCell")
        let cell = Bundle.main.loadNibNamed("CustomHealthCell", owner: self, options: nil)?.first as! CustomHealthCell
        healthcells.append(cell)
        cell.selectionStyle = .none
        tableView.reloadData()
    }
    @IBAction func addCustomHealthCellBtnDidTap(_ sender: Any) {
        let cell = Bundle.main.loadNibNamed("CustomHealthCell", owner: self, options: nil)?.first as! CustomHealthCell
        healthcells.append(cell)
        cell.selectionStyle = .none
        tableView.reloadData()
    }
    
}
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthcells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return healthcells[indexPath.row]
    }
    
    
}
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            healthcells.remove(at: indexPath.row)
            tableView.reloadData()
        default:
            break
        }
    }
}
