//
//  Constants.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/6/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import UIKit

//String Constants
let backFromSetting = "backFromSetting"
let locationMethodKey = "locationMethod"
let currentAddressKey = "currentAddress"

//Color Constants (the green one)
let navigationBarTintColor = UIColor.init(r: 201, g: 251, b: 82)

//Storyboard constant
let storyboard = UIStoryboard(name: "Main", bundle: nil)

//Network constant
let baseURL = URL(string: "https://evn-monitor.herokuapp.com")
let loginURL = URL(string: "\(baseURL!)/auth")
let fetchDataURL = URL(string: "\(baseURL!)/api/mobile/locations")
let registerURL = URL(string: "\(baseURL!)/users")
let nearbyDistrictsURL = URL(string: "\(baseURL!)/api/web/nearby")

//Map constant
let geocodingURL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?")
let geocodingAPIKey = "AIzaSyBddDGxR0o_xgI-TbNSxH0I5-0VIX3Mwyw"


public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
