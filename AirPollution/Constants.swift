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
let USERTOKEN = "UserToken"

//App delegate
let appDelegate = UIApplication.shared.delegate as! AppDelegate
var rootVC = appDelegate.window?.rootViewController

//Color Constants (the green one)
let navigationBarTintColor = UIColor.white

//Storyboard constant
let storyBoard = UIStoryboard(name: "Main", bundle: nil)
let MapVCStoryBoardID = "MapViewController"
let FullDashBoardVCStoryBoardID = "FullDashBoardController"
let SmartDashBoardVCStoryBoardID = "SmartDashBoardController"

//Network constant
let baseURL = URL(string: "http://ec2-52-221-209-59.ap-southeast-1.compute.amazonaws.com")
let loginURL = URL(string: "\(baseURL!)/auth")
let fetchDataURL = URL(string: "\(baseURL!)/api/mobile/locations")
let registerURL = URL(string: "\(baseURL!)/users")
let nearbyDistrictsURL = URL(string: "\(baseURL!)/api/mobile/v1/nearby")
let sensorsByDistrict = URL(string: "\(baseURL!)/api/mobile/v1/devices")

//Map constant
let geocodingURL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json?")
let geocodingAPIKey = "AIzaSyBddDGxR0o_xgI-TbNSxH0I5-0VIX3Mwyw"
let highAQIAnnotationView = UIImage(named: "highAQIAnnotation")
let mediumAQIAnnotationView = UIImage(named: "mediumAQIAnnotation")
let lowAQIAnnotationView = UIImage(named: "lowAQIAnnotation")

//UserDefault constant
let userDefaults = UserDefaults.standard

//Image constant
let backIcon = UIImage(named: "Back-Icon")
let greenBackIcon = UIImage(named: "Green-Back-Icon")

let sampleText = "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains..............."

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

//enum DISTRICT : Int {
//    case D1 = 0, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, THUDUC, GOVAP, BINHTHANH, TANBINH, TANPHU, PHUNHUAN, BINHTAN
//}
//
let districtsInHCM = [ "Quận 1",
                       "Quận 2",
                       "Quận 3",
                       "Quận 4",
                       "Quận 5",
                       "Quận 6",
                       "Quận 7",
                       "Quận 8",
                       "Quận 9",
                       "Quận 10",
                       "Quận 11",
                       "Quận 12",
                       "Thủ Đức",
                       "Gò Vấp",
                       "Bình Thạnh",
                       "Tân Bình",
                       "Tân Phú",
                       "Phú Nhuận",
                       "Bình Tân"
]


