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
        countTextFeild.keyboardType = .numberPad
        setCountTextFeild.keyboardType = .numberPad
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    @IBAction func startButtonDidTap(_ sender: Any) {
        guard let tableView = self.superview as? UITableView else {return}
        guard let indexPath = tableView.indexPath(for: self),
              let exerciseName = exerciseNameTextFeild.text,
            let count = Int(countTextFeild.text ?? ""),
            let setCount = Int(setCountTextFeild.text ?? "") else {return}
        
        let healthCellData = HealthCellData.init(indexPath: indexPath, exerciseName: exerciseName, count: count, setCount: setCount)
        print(indexPath)
        let dic = ["healthCellData": healthCellData]
        NotificationCenter.default.post(name: NSNotification.Name("startButtonDidTap"), object: nil, userInfo: dic)
    }
    
}
