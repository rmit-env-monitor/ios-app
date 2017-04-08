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
    static func getAddressForLatLng(latitude : String, longitude : String, completion : @escaping (_ currentLocation : Location?) -> ()) {
        let params = ["latlng" : latitude + "," + longitude, "key" : "\(geocodingAPIKey)"]
        var location : Location?
        Alamofire.request(geocodingURL!, method : .get, parameters : params).responseJSON { (response) in
            if let jsonResponse = response.result.value as? [String : AnyObject] {
                let jsonArray = jsonResponse["results"] as! [[String : AnyObject]]

                if let address = jsonArray[0]["address_components"] as? [[String : AnyObject]] {
                    location = Location(dictionary: address)
                }
                
            }
            completion(location)
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
                        let JSON = result as! [String : AnyObject]
                        print(JSON)
                        if JSON["message"] == nil {
                            Client.currentUser = User(dictionary: JSON)
                            userDefaults.set(JSON, forKey: "CurrentUser")
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
        print("Logout successfully")
    }
    
    //Load dashboard
    static func loadDashBoard(_ completion: @escaping (_ dataDictArray : [[String:AnyObject]]) -> ()) {
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        Alamofire.request(fetchDataURL!, method: .get, headers: header).responseJSON { (response) in
            if let result = response.result.value {
                let JSON = result as! [[String : AnyObject]]
                completion(JSON)
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
                        let JSON = result as! [String : AnyObject]
                        if JSON.count == 1 {
                            completion(false)
                        }
                        else {
                            completion(true)
                        }
                    }
                default:
                    print("error with response status : ", status)
                    completion(false)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
