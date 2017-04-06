//
//  SmartDashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/23/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit

class SmartDashBoardController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var currentLocation : CLLocationCoordinate2D? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var locationManager : LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        locationManager = LocationManager(SmartDashBoardViewController: self)
        NotificationCenter.default.addObserver(self, selector: #selector(requestAccess), name: NSNotification.Name(rawValue: backFromSetting), object: nil)
    }
    
    func requestAccess() {
        checkPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocationPermission()
        }
        else {
            checkPermission()
        }
    }
    
    func showUserLocation(userLocation : CLLocationCoordinate2D!) {
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(userLocation, span)
        
    }
    
    
    func checkPermission() {
        if locationManager.permissionStatus == .denied {
            let alert = UIAlertController(title: "Need Authorization", message: "This feature is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if locationManager.permissionStatus == .authorizedWhenInUse || locationManager.permissionStatus == .authorizedAlways {
            locationManager.requestLocationPermission()
        }
    }
    func setupUI() {
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem = logoutButton
        self.navigationItem.title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.gray
    }
    
    
    
    func onLogout() {
        Client.logout()
        Client.userDefaults.removeObject(forKey: "locatingMethod")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK : Setup table view
extension SmartDashBoardController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
            let span = MKCoordinateSpanMake(0.01, 0.01)
            if currentLocation != nil {
                let region = MKCoordinateRegionMake(currentLocation!, span)
                cell.mapView.setRegion(region, animated: true)
                cell.mapView.showsUserLocation = true
            }
          
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}


















