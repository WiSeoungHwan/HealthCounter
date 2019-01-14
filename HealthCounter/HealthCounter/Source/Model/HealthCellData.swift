//
//  HealthCellData.swift
//  HealthCounter
//
//  Created by Wi on 31/12/2018.
//  Copyright © 2018 Wi. All rights reserved.
//

import Foundation

struct HealthCellData: Codable{
    var isCustomCell: Bool
    var isTimerCellOpen: Bool?
    let indexPath: IndexPath?
    var exerciseName: String?
    var count: Int?
    var setCount: Int?
}
