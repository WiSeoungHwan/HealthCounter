//
//  RoutinData.swift
//  HealthCounter
//
//  Created by Wi on 07/01/2019.
//  Copyright © 2019 Wi. All rights reserved.
//

import UIKit

struct RoutineData: Codable {
    let routineName: String
    let HealthCellDatas: [HealthCellData]
}
