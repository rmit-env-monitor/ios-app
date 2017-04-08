//
//  SmartDashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/23/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit
import OpenSansSwift
import GooglePlaces

class SmartDashBoardController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var currentAddress : Location?
    
    var currentLocation : CLLocationCoordinate2D? {
        didSet {
            let latitude = "\((currentLocation?.latitude)!)"
            let longitude = "\((currentLocation?.longitude)!)"
            
            Client.getAddressForLatLng(latitude: latitude, longitude: longitude) { (address) in
                guard address != nil else {
                    return
                }
                self.currentAddress = address
            }
        }
    }
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchLocationController : UISearchController!
    
    var locationManager : LocationManager!
    var suggestedLocationVC : SuggestedLocationViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarUI()
        setupUI()
        locationManager = LocationManager(SmartDashBoardViewController: self)
        NotificationCenter.default.addObserver(self, selector: #selector(checkPermission), name: NSNotification.Name(rawValue: backFromSetting), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkPermission()
    }
    
    func checkPermission() {
        let permissionStatus = locationManager.permissionStatus
        if permissionStatus == .denied {
            let alert = UIAlertController(title: "Need Authorization", message: "This feature is unusable if you don't authorize this app to use your location!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
                let url = URL(string: UIApplicationOpenSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if permissionStatus == .authorizedWhenInUse || permissionStatus == .authorizedAlways {
            if Client.userDefaults.object(forKey: locationMethodKey) as? String == "\(locationMethod.manually)" {
             
            }
            else {
                locationManager.requestLocationPermission()
            }
        }
    }
    
    func setupSearchBarUI() {
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        searchLocationController = UISearchController(searchResultsController: resultsViewController)
        searchLocationController.searchResultsUpdater = resultsViewController
        
        searchLocationController.hidesNavigationBarDuringPresentation = false
        searchLocationController.searchBar.searchBarStyle = .minimal
        let searchBarTextField = searchLocationController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = navigationBarTintColor
        searchBarTextField?.font = UIFont.openSansFontOfSize(16)
        
        self.navigationItem.titleView = self.searchLocationController.searchBar
        self.definesPresentationContext = true
    }
    
    
    
    func setupUI() {
        _ = OpenSans.registerFonts()
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem = logoutButton
        
        self.navigationItem.title = "Current Location"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.gray
    }
    
    func onLogout() {
        Client.logout()
        Client.userDefaults.removeObject(forKey: locationMethodKey)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK : Setup Autocomplete TableView DataSource
extension SmartDashBoardController : GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        //print("Place name: \(place.name)")
        //print("Place address: \(place.formattedAddress)")
        Client.getAddressForLatLng(latitude: "\(place.coordinate.latitude)", longitude: "\(place.coordinate.longitude)") { (location) in
            location?.printAddress()
        }
        //print("Place attributions: \(place.attributions)")
        resultsController.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

//MARK : Setup table view
extension SmartDashBoardController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //TODO : showing current location
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


















