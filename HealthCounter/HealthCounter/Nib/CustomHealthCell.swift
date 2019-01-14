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
    
    var model: HealthCellData! {
        didSet{
            exerciseNameTextFeild.text = model.exerciseName
            if model.count != nil, model.setCount != nil{
                countTextFeild.text = "\(model.count!)"
                setCountTextFeild.text = "\(model.setCount!)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        exerciseNameTextFeild.delegate = self
        countTextFeild.delegate = self
        setCountTextFeild.delegate = self
        self.contentView.layer.cornerRadius = 18
        countTextFeild.keyboardType = .numberPad
        setCountTextFeild.keyboardType = .numberPad
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
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
        let healthCellData = HealthCellData.init(isCustomCell: false, isTimerCellOpen: false, indexPath: indexPath, exerciseName: exerciseName, count: count, setCount: setCount)
        print(indexPath)
        let dic = ["healthCellData": healthCellData]
        NotificationCenter.default.post(name: NSNotification.Name("startButtonDidTap"), object: nil, userInfo: dic)
    }
    
    
    
}
extension CustomHealthCell: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // hide Keyboard
        return true
    }
    
}
