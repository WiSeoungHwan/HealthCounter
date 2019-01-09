//
//  MainTabBarController.swift
//  HealthCounter
//
//  Created by Wi on 09/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadRoutine), name: NSNotification.Name("loadRoutine"), object: nil)
    }
    @objc private func loadRoutine(){
        self.selectedIndex = 0
    }

}
