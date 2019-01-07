//
//  RoutineTableViewCell.swift
//  HealthCounter
//
//  Created by Wi on 07/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

class RoutineTableViewCell: UITableViewCell {
    @IBOutlet weak var routineNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 18
    }
    
    @IBAction func loadRoutineButtonDidTap(_ sender: Any) {
        //운동 창으로 이동 후 루틴에 해당하는 데이터 뿌려주기
        
    }
}
