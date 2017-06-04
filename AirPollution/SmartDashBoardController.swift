//
//  SmartDashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/23/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces
import UserNotifications
import FirebaseMessaging
import FirebaseInstanceID
import Firebase

class SmartDashBoardController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchLocationController : UISearchController!
    var nearbyDistricts = [String]()
    var toDetailDistrict : String!
    var locationManager : LocationManager!
    
    var currentLocation : CLLocationCoordinate2D? {
        didSet {
            let latitude = "\((currentLocation?.latitude)!)"
            let longitude = "\((currentLocation?.longitude)!)"
            let locationDictionary = ["latitude" : currentLocation?.latitude, "longitude" : currentLocation?.longitude]
            Client.userDefaults.set(locationDictionary, forKey:  currentAddressKey)
            Client.getAddressForLatLng(latitude: latitude, longitude: longitude) { (address, fullAddress) in
                if address != nil {
                    self.currentAddress = address
                }
                //print(fullAddress!)
            }
        }
    }
    
    
    var currentAddress : Location? {
        didSet {
            let city : String! = currentAddress!.city
            let district : String! = currentAddress!.district
            Client.getNearbyDistricts(district, city) { (response) in
                if let nearbyDistrictsArray = response {
                    self.nearbyDistricts = !nearbyDistrictsArray.isEmpty ? nearbyDistrictsArray : [String]()
                }
                self.tableView.reloadData()
                self.tableView.alpha = 1
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarUI()
        setupUI()
        
        locationManager = LocationManager(SmartDashBoardViewController: self)
        //UIApplication.shared.windows[0].rootViewController = EsTabBarController.sharedInstance.open()

        NotificationCenter.default.addObserver(self, selector: #selector(checkPermissionAndMethodLocation), name: NSNotification.Name(rawValue: backFromSetting), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkPermissionAndMethodLocation()
        checkPermissionNotification()
    }
    
    func requestPushNotificationPermission() {
        if #available(iOS 10, *) {
            let authOptions : UNAuthorizationOptions = [.badge, .alert, .sound]
            
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { (_, _) in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func checkPermissionNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            let permissionStatus = settings.authorizationStatus
            if permissionStatus == .denied {
//                let alert = UIAlertController(title: "Need Permission", message: "This feature is unusable if you don't permit this app to push notification!", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//                alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
//                    let url = URL(string: UIApplicationOpenSettingsURLString)!
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                }))
//                self.present(alert, animated: true, completion: nil)
            }
            else if permissionStatus == .notDetermined {
                self.requestPushNotificationPermission()
            }
        }
    }
    
    func checkPermissionAndMethodLocation() {
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
        else if permissionStatus == .notDetermined {
            locationManager.requestLocationPermission()
            print("Not Determined")
        }
        else if permissionStatus == .restricted {
            print("Restricted, You can do nothing :((")
        }
        else if (permissionStatus == .authorizedWhenInUse || permissionStatus == .authorizedAlways) && self.currentAddress == nil {
            if Client.userDefaults.object(forKey: locationMethodKey) as? String == "\(locationMethod.manually)" {
                if currentAddress == nil {
                    DispatchQueue.main.async { [weak self] in
                        self?.searchLocationController.searchBar.becomeFirstResponder()
                    }
                }
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
        searchLocationController.dimsBackgroundDuringPresentation = false
        let searchBarTextField = searchLocationController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = navigationBarTintColor
        searchBarTextField?.font = UIFont.getFutura(fontSize: 16)
        
        self.navigationItem.titleView = self.searchLocationController.searchBar
        self.definesPresentationContext = true
    }
    
    func setupUI() {
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem = logoutButton

        
        if let cacheCurrentLocation = Client.userDefaults.object(forKey: currentAddressKey) as? [String : CLLocationDegrees] {
            self.currentLocation = CLLocationCoordinate2DMake(cacheCurrentLocation["latitude"]! , cacheCurrentLocation["longitude"]!)
        }
        else {
            tableView.alpha = 0
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.white
    }
    
    func onLogout() {
        Client.logout()
        EsTabBarController.sharedInstance.close()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailViewSegue" {
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.navigationTitle = toDetailDistrict
            destinationViewController.city = self.currentAddress?.city!
        }
    }
    
}

//MARK : Setup Autocomplete TableView DataSource
extension SmartDashBoardController : GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        //print("Place name: \(place.name)")
        //print("Place address: \(place.formattedAddress)")
        currentLocation = place.coordinate
        //print("Place attributions: \(place.attributions)")
        searchLocationController.searchBar.text = nil
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmartDashboardCell") as! SmartDashBoardCell
        cell.accessoryType = .disclosureIndicator
        if currentAddress != nil {
            if indexPath.section == 0 {
                if currentAddress != nil {
                    cell.districtLabel.text = "\((self.currentAddress!.district)!)"
                    cell.aqhiLabel.text = "AQHI: 0"
                }
                
            }
            else if indexPath.section == 1 {
                cell.districtLabel.text = "\(self.nearbyDistricts[indexPath.row])"
                cell.aqhiLabel.text = "AQHI: 0"
            }
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SmartDashBoardCell
        toDetailDistrict = cell.districtLabel.text
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ToDetailViewSegue", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if nearbyDistricts.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
            messageLabel.font = UIFont.getFutura(fontSize: 15)
            messageLabel.textColor = .black
            messageLabel.text = "No Data Available, Your Location is not at Ho Chi Minh City"
            messageLabel.textAlignment = .center
            messageLabel.sizeToFit()
            messageLabel.numberOfLines = 0
            
            self.tableView.backgroundView = messageLabel
            self.tableView.separatorStyle = .none
            
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
            
        case 1:
            return nearbyDistricts.count
        default : return 0
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if currentAddress != nil {
                return "\((self.currentAddress?.fullAddress)!)"
            }
            return "Cannot detect location yet!"
        case 1:
            return "Districts Nearby"
        default: return "None"
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if currentAddress != nil {
            return 30
        }
        return 0
    }
}


















