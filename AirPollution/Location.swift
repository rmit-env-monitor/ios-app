//
//  Location.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/25/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation

class Location {

    var streetNumber : String?
    var city : String?
    var street : String?
    var district : String?
    
    init(dictionary : [[String : AnyObject]]) {
        self.streetNumber = dictionary[0]["long_name"] as? String
        self.street = dictionary[1]["long_name"] as? String
        self.city = dictionary[3]["long_name"] as? String
        self.district = dictionary[4]["long_name"] as? String
    }
}
