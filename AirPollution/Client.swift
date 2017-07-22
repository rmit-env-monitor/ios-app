//
//  Client.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD


class Client {
    static var currentUser : User?
    
    //Get location based on Longtitude and Lantitude
    static func getAddressForLatLng(latitude : String, longitude : String, completion : @escaping (_ currentLocation : Location?, _ fullAddress : String?) -> ()) {
        let params = ["latlng" : latitude + "," + longitude, "key" : "\(geocodingAPIKey)"]
        var location : Location?
        var address = ""
        Alamofire.request(geocodingURL!, method : .get, parameters : params).responseJSON { (response) in
            if let jsonResponse = response.result.value as? [String : AnyObject] {
                if let jsonArray = jsonResponse["results"] as? [[String : AnyObject]] {
                    let fullAddress = jsonArray[0]["formatted_address"] as! String
                    var fullAddressComponents = fullAddress.components(separatedBy: ", ")
                    var locationComponents = [String : String]()
                    for component in fullAddressComponents {
                        if fullAddressComponents.index(of: component) == 1 {
                            locationComponents["ward"] = fullAddressComponents[1]
                            address = "\(fullAddressComponents[1])"
                        }
                        else if fullAddressComponents.index(of: component) == 2 {
                            locationComponents["district"] = fullAddressComponents[2]
                            address = address + ", \(fullAddressComponents[2])"
                        }
                        else if fullAddressComponents.index(of: component) ==  3 {
                            locationComponents["city"] = fullAddressComponents[3]
                            address = address + ", \(fullAddressComponents[3])"
                        }
                    }
                    location = Location(dictionary: locationComponents, address: address)
                }
            }
            completion(location,address)
        }
    }
    
    //Login
    static func login(_ params : [String : Any], completion : @escaping ([String:String])->()) {
        HUD.show(.progress)
        Alamofire.request(loginURL, method: .post, parameters: params).responseJSON { (response) in
            guard let status = response.response?.statusCode else { return }
            switch status {
            case 200:
                guard let jsonResponse = response.result.value as? [String: String] else { return }
                completion(jsonResponse)
                HUD.hide()
            default:
                print("error with response status : ", status)
                completion(["message": "Something wrong happened:("])
                HUD.hide()
            }
            
        }
    }
    
    //Logout
    static func logout() {
        HUD.show(.progress)
        //userDefaults.removeObject(forKey: currentUserKey)
        userDefaults.removeObject(forKey: locationMethodKey)
        userDefaults.removeObject(forKey: currentAddressKey)
        NotificationCenter.default.post(name: Notification.Name("handleTabBarControllerWhenLoggedOut"), object: nil)
        print("Logout successfully")
        HUD.hide()
    }
    
    //Load DashBoard
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
    static func register(_ params : [String : String], completion : @escaping (String) -> ()) {
        Alamofire.request(registerURL!, method: .post, parameters: params).validate().responseJSON { (response) in
            if let status = response.response?.statusCode {
                switch status {
                case 200:
                    print("Register Successfully")
                    if let result = response.result.value {
                        guard let jsonResponse = result as? [String : AnyObject] else { return }
                        if jsonResponse.count == 1 {
                            completion(jsonResponse["message"] as! String)
                        }
                        else {
                            completion("")
                        }
                    }
                default:
                    print("register error with response status : ", status)
                    completion("Error: \(status)")
                }
            }
        }
    }
    
    //Get nearby districts
    static func getNearbyDistricts(_ district : String, _ city : String, _ completion : @escaping ([String]?) -> ()) {
        HUD.show(.progress)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        let params = ["city" : city, "district" : district]
        
        var districtsArray = [String]()
        Alamofire.request(nearbyDistrictsURL!, method: .get, parameters: params, headers: header).responseJSON { (response) in
            guard let status = response.response?.statusCode else { return }
            switch status {
            case 200:
                if let jsonResponse = response.result.value as? [String] {
                    if !jsonResponse.isEmpty {
                        districtsArray = jsonResponse
                        completion(districtsArray)
                        HUD.hide()
                        return
                    }
                    HUD.hide()
                }
            default:
                print("get nearby districts error with response status : ", status)
                completion(nil)
                HUD.hide()
                return
            }
        }
    }
    
    //Get all sensors based on districts
    static func getSensorsByDistricts(District district : String, _ city : String, _ completion : @escaping ([Sensor]?) -> ()) {
        HUD.show(.progress)
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        let params = ["city" : city, "district" : district]
        
        Alamofire.request(sensorsByDistrict!, method: .get, parameters: params, headers: header).responseJSON { (response) in
            var sensors = [Sensor]()
            guard let status = response.response?.statusCode else { return }
            switch status {
            case 200:
                if let result = response.result.value as? [NSDictionary] {
                    for element in result {
                        
                        let id = element["_id"] as! String
                        let name = element["name"] as! String
                        sensors.append(Sensor(id: id , name: name))
                    }
                }
                completion(sensors)
                HUD.hide()
                return
            default:
                print("get nearby districts error with response status : ", status)
                completion(nil)
                HUD.hide()
                return
            }
        }
    }
    
    
    
    
    
    
    
    
}
