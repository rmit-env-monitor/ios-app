//
//  Extension.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 6/5/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension UIFont {
    static func getFutura(fontSize : CGFloat) -> UIFont {
        return UIFont(name: "Futura", size: fontSize)!
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red : r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
    
    static var airPollutionGreen : UIColor {
        return UIColor(r: 0, g: 204, b: 153)
    }
}

extension UIViewController {
    static func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabBarController = controller as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return topViewController(controller: selectedViewController)
            }
        }
        if let presentedViewController = controller?.presentedViewController {
            return topViewController(controller: presentedViewController)
        }
        return controller
    }
}

extension CLLocationManager {
    func requestLocationPermission() {
        self.requestWhenInUseAuthorization()
        self.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.desiredAccuracy = kCLLocationAccuracyBest
            self.startUpdatingLocation()
        }
    }
}
