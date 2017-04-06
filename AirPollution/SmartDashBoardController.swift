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
    
    
    
    var currentLocation : CLLocationCoordinate2D?

    
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        locationManager.viewController = self
        NotificationCenter.default.addObserver(self, selector: #selector(locationManager.requestLocationPermission), name: NSNotification.Name(rawValue: backFromSetting), object: nil)
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        locationManager.requestLocationPermission()
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


















