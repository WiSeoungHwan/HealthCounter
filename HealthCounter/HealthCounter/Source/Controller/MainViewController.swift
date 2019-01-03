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
        guard let cell = Bundle.main.loadNibNamed("CustomHealthCell", owner: self, options: nil)?.first as? CustomHealthCell else {print("Cell Nib load err"); return}
        //셀의 경계선 투명으로
        tableView.separatorColor = .clear
        healthcells.append(cell)
        cell.selectionStyle = .none
        tableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(startButtonDidTap), name: NSNotification.Name(rawValue: "startButtonDidTap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: NSNotification.Name("reloadTableView"), object: nil)
    }
    
    @objc private func startButtonDidTap(_ noti: Notification){
        guard let userInfo = noti.userInfo as? [String: HealthCellData], let healthData = userInfo["healthCellData"] else { print("healthCellData Noti err"); return }
        
        healthcells.remove(at: healthData.indexPath.section)
        guard let cell = Bundle.main.loadNibNamed("HealthCell", owner: self, options: nil)?.first as? HealthCell else {print("Cell Nib load err"); return}
        cell.selectionStyle = .none
        cell.model = healthData
        healthcells.insert(cell, at: healthData.indexPath.section)
        tableView.reloadData()
    }
    
    @IBAction func addCustomHealthCellBtnDidTap(_ sender: Any) {
        guard let cell = Bundle.main.loadNibNamed("CustomHealthCell", owner: self, options: nil)?.first as? CustomHealthCell else {print("Cell Nib load err"); return}
        healthcells.append(cell)
        cell.selectionStyle = .none
        tableView.reloadData()
    }
    @objc private func reloadTableView(){
        tableView.reloadData()
    }
}
extension MainViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return healthcells.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let healthCell = healthcells[section] as? HealthCell else {return 1}
        if healthCell.model.isTimerCellOpen == true{
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            return healthcells[indexPath.section]
        }else{
            guard let timerCell = Bundle.main.loadNibNamed("TimerTableViewCell", owner: self, options: nil)?.first as? TimerTableViewCell else {print("Cell Nib load err"); return UITableViewCell()}
            return timerCell
            
        }
        
    }
    
    
}
extension MainViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            healthcells.remove(at: indexPath.section)
            tableView.reloadData()
        default:
            break
        }
    }
}
