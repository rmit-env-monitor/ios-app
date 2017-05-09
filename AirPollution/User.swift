//
//  User.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation

class User : NSObject {
    var name : String!
    var token : String!

    init(dictionary : [String : AnyObject]) {
        self.name = dictionary["username"] as! String
        self.token = dictionary["token"] as! String
    }
    
    
    
}
