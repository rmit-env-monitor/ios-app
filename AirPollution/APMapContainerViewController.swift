//
//  MapContainerViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/9/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit

class APMapContainerViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    fileprivate let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func requestLocationPermission(presentingViewController: UIViewController) {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            let alert = UIAlertController(title: "Need authorization", message: "This feature is unusable if you do not authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            presentingViewController.present(alert, animated: true, completion: nil)
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
        case .restricted:
            print("Restricted")
        default:
            print("None of these cases")
        }
    }
    
}
