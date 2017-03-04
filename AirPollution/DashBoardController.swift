//
//  DashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import Alamofire

class DashBoardController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let header : HTTPHeaders = [
            "Authorization" : "Bearer \(Client.currentUser!.token!)"
        ]
        Alamofire.request("http://10.247.216.231:3000/api/mobile/locations", method: .get, headers: header).responseJSON { (response) in
            if let result = response.result.value {
                let JSON = result as! [[String : AnyObject]]
                print(JSON)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
