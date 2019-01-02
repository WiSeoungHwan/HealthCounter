//
//  HealthCell.swift
//  HealthCounter
//
//  Created by Wi on 31/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class HealthCell: UITableViewCell {
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var setCountLabel: UILabel!
    var model: HealthCellData! {
        didSet{
            exerciseNameLabel.text = model.exerciseName
            countLabel.text = "세트당 횟수: \(model.count)"
            setCountLabel.text = "남은세트:\(model.setCount)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 18
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func setFinishButtonDidTap(_ sender: Any) {
        if model.setCount > 0 {
            model.setCount -= 1
        }
        NotificationCenter.default.post(name: NSNotification.Name("reloadTableView"), object: nil)
    }
}
