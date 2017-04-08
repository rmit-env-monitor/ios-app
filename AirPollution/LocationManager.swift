//
//  LocationManager.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/6/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import MapKit

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    var viewController : SmartDashBoardController?
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    override init() {
        super.init()
        
    }
    
    
    convenience init(SmartDashBoardViewController : SmartDashBoardController) {
        self.init()
        locationManager.delegate = self
        self.viewController = SmartDashBoardViewController
    }
    
    var permissionStatus : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        if Client.userDefaults.string(forKey: "locationMethod")! == "automatically" {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            self.currentLocation = locValue
           self.viewController?.currentLocation = locValue
        }
    }
}
