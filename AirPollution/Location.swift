//
//  Location.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/25/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation

class Location : NSObject {
 
    var city : String?

    var district : String?
    var ward : String?
    //var country : Strig!
    var fullAddress : String?
    
    
    init(dictionary : [String : String], address : String) {
        self.ward = dictionary["ward"]
        self.city = dictionary["city"]
        self.district = dictionary["district"]!
        self.fullAddress = address
    }
    
    func printAddress() {
        print("\((self.district)!)")
    }
}
