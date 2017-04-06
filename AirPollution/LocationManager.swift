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
    var viewController : UIViewController!
    
    func requestLocationPermission() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            //Show Alert with link to settings
            let alert = UIAlertController(title: "Need Authorization", message: "This feature is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            viewController.present(alert, animated: true, completion: nil)
        case .restricted:
            print("Being restricted")
        default : break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if Client.userDefaults.string(forKey: "locationMethod")! == "automatically" {
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            self.currentLocation = locValue
            print("locations = \(currentLocation!.latitude) \(currentLocation!.longitude)")
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    
    
}
