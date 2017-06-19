//
//  LocationManager.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/6/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import MapKit

class LocationManager : CLLocationManager {
    
    static var currentLocation : Location?
    
  
//    func requestLocationPermission() {
//        self.requestWhenInUseAuthorization()
//        self.requestAlwaysAuthorization()
//        self.delegate = self
//        if CLLocationManager.locationServicesEnabled() {
//            self.desiredAccuracy = kCLLocationAccuracyBest
//            self.startUpdatingLocation()
//        }
//    }
//    
    var permissionStatus : CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    
}

//MARK: conform CLLocationManagerDelegate method
extension LocationManager : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.stopUpdatingLocation()
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        Client.getAddressForLatLng(latitude: "\(locValue.latitude)", longitude: "\(locValue.longitude)", completion: { (location, address) in
            LocationManager.currentLocation = location
        })
        print("\(locValue.latitude)")
    }
}

