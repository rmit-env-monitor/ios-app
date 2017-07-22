//
//  APUltils.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import UIKit

class APUltils {
    
    static func presentAlertController(title: String, message: String = "", completionHandler: @escaping ()-> ()) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            alertController.dismiss(animated: true) { completionHandler() }
        }
        alertController.addAction(okAction)
        UIViewController.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}
