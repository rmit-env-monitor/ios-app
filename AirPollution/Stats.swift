//
//  Stats.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/8/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class Stats: NSObject {
    var o3 : Int?
    var latitude : Int?
    var no : Int?
    var longitude : Int?
    var pm : Int?   //dust
    var so2: Int?
    var sound : Int?
    var utcDateTime : Int?
    
    init(dictionary : [String : AnyObject]) {
        self.o3 = dictionary["o3"] as? Int
        self.latitude = dictionary["latitude"] as? Int
        self.no = dictionary["no"] as? Int
        self.longitude = dictionary["longtitude"] as? Int
        self.pm = dictionary["pm"] as? Int
        self.so2 = dictionary["so2"] as? Int
        self.sound = dictionary["sound"] as? Int
        self.utcDateTime = dictionary["utcDateTime"] as? Int
    }
}
