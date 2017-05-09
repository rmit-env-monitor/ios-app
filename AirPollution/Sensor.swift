//
//  Sensor.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation

class Sensor {
    var id : String?
    var name : String?
    var stats : Stats?
    
    init(id : String, name : String) {
        self.id = id
        self.name = name
    }
}
