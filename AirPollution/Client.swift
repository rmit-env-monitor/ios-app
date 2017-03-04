//
//  Client.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = URL(string: "http://10.247.216.231:3000/")
let loginURL = URL(string: "http://10.247.216.231:3000/auth")
let userDefaults = UserDefaults.standard


class Client {
    static var currentUser : User?
    
    //Login
    static func login(params : [String : AnyObject], completion : @escaping ()->()) {
        Alamofire.request(loginURL!, method: .post, parameters: params, encoding : JSONEncoding.default).validate().responseJSON { (response) in
            
            if let status = response.response?.statusCode {
                switch status {
                    case 200:
                        print("Login Successfully")
                    default:
                        print("error with response status : ", status)
                }
            }
            
            if let result = response.result.value {
                let JSON = result as! [String : AnyObject]
                Client.currentUser = User(dictionary: JSON)
                userDefaults.set(Client.currentUser?.token, forKey: "token")
                print(JSON)
            }
            completion()
        }
    }
    
    
    //Logout
    static func logout() {
        
    }
    
    
    //Load dashboard
    static func loadDashBoard() {
        
    }
    
}
