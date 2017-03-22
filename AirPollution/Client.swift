//
//  Client.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = URL(string: "https://evn-monitor.herokuapp.com")
let loginURL = URL(string: "\(baseURL!)/auth")
let fetchDataURL = URL(string: "\(baseURL!)/api/mobile/locations")
let registerURL = URL(string: "\(baseURL!)/users")

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

class Client {
    static var currentUser : User?
    static let userDefaults = UserDefaults.standard
    
    //Login
    static func login(params : [String : AnyObject], completion : @escaping (Bool)->()) {
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
    static func loadDashBoard(completion: @escaping (_ dataDictArray : [[String:AnyObject]]) -> ()) {
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
    static func register(params : [String : AnyObject], completion : @escaping (Bool) -> ()) {
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
