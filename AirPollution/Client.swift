//
//  Client.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import Alamofire



class Client {
    static var currentUser : User?
    static let userDefaults = UserDefaults.standard
    
    //Get location based on Longtitude and Lantitude
    static func getAddressForLatLng(latitude : String, longitude : String, completion : @escaping (_ currentLocation : Location?, _ fullAddress : String?) -> ()) {
        let params = ["latlng" : latitude + "," + longitude, "key" : "\(geocodingAPIKey)"]
        var location : Location?
        var address : String?
        Alamofire.request(geocodingURL!, method : .get, parameters : params).responseJSON { (response) in
            if let jsonResponse = response.result.value as? [String : AnyObject] {
            
                if let jsonArray = jsonResponse["results"] as? [[String : AnyObject]] {
                    let fullAddress = jsonArray[0]["formatted_address"] as! String
                    
                    var addressComponents = fullAddress.components(separatedBy: ", ")
                    let ward = addressComponents[1]
                    let district = addressComponents[2]
                    let city = addressComponents[3]
                    let locationComponents = [ "ward" : ward,
                                               "district" : district ,
                                               "city" : city
                    ]
                    
                    location = Location(dictionary: locationComponents)
                    address = "\(ward), \(district), \(city)"
                }
                
            
                
            }
            completion(location,address)
        }
    }
    
    //Login
    static func login(_ params : [String : AnyObject], completion : @escaping (Bool)->()) {
        Alamofire.request(loginURL!, method: .post, parameters: params, encoding : JSONEncoding.default).validate().responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    //print("Login Successfully")
                    if let result = response.result.value {
                        let jsonResponse = result as! [String : AnyObject]
                        if jsonResponse["message"] == nil {
                            Client.currentUser = User(dictionary: jsonResponse)
                            userDefaults.set(jsonResponse, forKey: currentUserKey)
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                    }
                    
                default:
                    print("error with response status : ", status)
                    completion(false)
                }
            }
        }
    }
    
    //Logout
    static func logout() {
        Client.userDefaults.removeObject(forKey: "CurrentUser")
        Client.userDefaults.removeObject(forKey: locationMethodKey)
        Client.userDefaults.removeObject(forKey: currentAddressKey)
                NotificationCenter.default.post(name: Notification.Name("handleTabBarControllerWhenLoggedOut"), object: nil)
        print("Logout successfully")
    }
    
    //Load dashboard
    static func loadDashBoard(_ completion: @escaping (_ dataDictArray : [[String:AnyObject]]) -> ()) {
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        Alamofire.request(fetchDataURL!, method: .get, headers: header).responseJSON { (response) in
            if let result = response.result.value {
                let jsonResponse = result as! [[String : AnyObject]]
                completion(jsonResponse)
            }
        }
    }
    
    //Register
    static func register(_ params : [String : AnyObject], completion : @escaping (Bool) -> ()) {
        Alamofire.request(registerURL!, method: .post, parameters: params).validate().responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    print("Register Successfully")
                    if let result = response.result.value {
                        let jsonResponse = result as! [String : AnyObject]
                        if jsonResponse.count == 1 {
                            completion(false)
                        }
                        else {
                            completion(true)
                        }
                    }
                default:
                    print("register error with response status : ", status)
                    completion(false)
                }
            }
        }
    }
    
    //Get nearby districts
    static func getNearbyDistricts(_ district : String, _ city : String, _ completion : @escaping ([String]?) -> ()) {
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        let params = ["city" : city, "district" : district]
        
        var districtsArray = [String]()
        Alamofire.request(nearbyDistrictsURL!, method: .get, parameters: params, headers: header).responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if let jsonResponse = response.result.value as? [String : AnyObject] {
                        if !jsonResponse.isEmpty {
                            districtsArray = jsonResponse["nearby"] as! [String]
                            completion(districtsArray)
                            return
                        }
                    }
                default:
                    print("get nearby districts error with response status : ", status)
                    completion(nil)
                    return
                }
            }
        }
    }
    
    //Get all sensors based on districts
    static func getSensorsByDistricts(_ district : String, _ city : String, _ completion : @escaping ([Sensor]?) -> ()) {
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        let params = ["city" : city, "district" : district]
        
        Alamofire.request(sensorsByDistrict!, method: .get, parameters: params, headers: header).responseJSON { (response) in
            var sensors = [Sensor]()
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    if let result = response.result.value as? [[String : String]] {
                        for element in result {
                            sensors.append(Sensor(id: element["_id"]! , name: element["name"]!))
                        }
                    }
                    completion(sensors)
                    return
                default:
                    print("get nearby districts error with response status : ", status)
                    completion(nil)
                    return
                }
            }
        }
    }
    
    
    
    
    
    
    
    
}
