//
//  TimerTableViewCell.swift
//  HealthCounter
//
//  Created by Wi on 02/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
        var timer = Timer()
        var counter: Double = 0.0
    @IBOutlet weak var countLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 18
        
        
    }
    var isTimerRunning = false
    @IBAction func startButtonDidTap(_ sender: Any) {
        if !isTimerRunning{
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
        isTimerRunning = true
    }
    @IBAction func pauseButtonDidTap(_ sender: Any) {
        isTimerRunning = false
        timer.invalidate()
    }
    @IBAction func stopButtonDidTap(_ sender: Any) {
        isTimerRunning = false
        counter = 0
        countLabel.text = "\(counter)"
        timer.invalidate()
    }
    @objc private func updateCounter(){
        counter += 0.1
        countLabel.text = String(format: "%.1f", counter)
    }
    
}
