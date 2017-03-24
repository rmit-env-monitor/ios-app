//
//  Location.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/25/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation

class Location : NSObject {
    var longitude : Float?
    var latitude : Float?
    
    init(longitude : Float, latitude : Float) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
