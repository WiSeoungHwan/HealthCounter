//
//  CustomHealthCell.swift
//  HealthCounter
//
//  Created by Wi on 31/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import UIKit

class CustomHealthCell: UITableViewCell {
    @IBOutlet weak var exerciseNameTextFeild: UITextField!
    @IBOutlet weak var countTextFeild: UITextField!
    @IBOutlet weak var setCountTextFeild: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func startButtonDidTap(_ sender: Any) {
        
    }
    
}
