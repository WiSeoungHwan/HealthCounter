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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    func configure(){
        tableView.register(UINib(nibName: "CustomHealthCell", bundle: nil), forCellReuseIdentifier: "CustomHealthCell")
        tableView.register(UINib(nibName: "HealthCell", bundle: nil), forCellReuseIdentifier: "HealthCell")
    }

}
extension MainViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomHealthCell", for: indexPath)
        return cell
    }
    
    
}
extension MainViewController: UITableViewDelegate{
    
}
