//
//  MapViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/16/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarUI()
        mapView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        showAnnotation()
    }

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchLocationController : UISearchController!
    
    func showAnnotation() {
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1,longitudeDelta: 0.1)
        if let currentLocation = Client.userDefaults.object(forKey: currentAddressKey) as? [String : AnyObject] {
           
            let lat  = currentLocation["latitude"] as! Double
            let lon  = currentLocation["longitude"] as! Double
            
            let location = CLLocationCoordinate2DMake(lat, lon)
            let annotation = MKPointAnnotation()
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
            annotation.coordinate = location
            annotation.title = "Sensor 1"
            annotation.subtitle = "AQHI: 212"
        
            self.mapView.addAnnotation(annotation)

        }
    }
    
    func setupSearchBarUI() {
        resultsViewController = GMSAutocompleteResultsViewController()
        //resultsViewController?.delegate = self
        searchLocationController = UISearchController(searchResultsController: resultsViewController)
        searchLocationController.searchResultsUpdater = resultsViewController
        
        searchLocationController.hidesNavigationBarDuringPresentation = false
        searchLocationController.searchBar.searchBarStyle = .minimal
        searchLocationController.dimsBackgroundDuringPresentation = false
        let searchBarTextField = searchLocationController.searchBar.value(forKey: "searchField") as? UITextField
        searchBarTextField?.textColor = navigationBarTintColor
        searchBarTextField?.font = UIFont.openSansFontOfSize(16)
        
        self.navigationItem.titleView = self.searchLocationController.searchBar
        self.definesPresentationContext = true
    }

}

extension MapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKPointAnnotation) {
            print("NOT AN ANNOTATION")
            return nil
        }
        
        let identifier = "Custom Annotation"
        
        //check if the annotation view is already in the reuse queue
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        //if there is no annotation, create one
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            let detailButton = UIButton(type: .detailDisclosure)
            detailButton.addTarget(self, action: #selector(handleOpenDetailView), for: .touchUpInside)
            annotationView!.rightCalloutAccessoryView = detailButton
            
        }
        //if it exits, update the annotation object of the dequeued annotation View
        else {
            annotationView!.annotation = annotation
        }
        
        annotationView!.image = UIImage(named: "annotation")
        let aqhiLabel = UILabel(frame: CGRect(x: 0, y: 0, width: annotationView!.image!.size.width - 5, height: annotationView!.image!.size.height))
        aqhiLabel.text = "212"
        aqhiLabel.textAlignment = .center
        aqhiLabel.font = UIFont(name: "Futura", size: 15)
        aqhiLabel.textColor = UIColor.white
        annotationView!.addSubview(aqhiLabel)
        return annotationView
    }
    
    func handleOpenDetailView() {
        let statsVC = storyBoard.instantiateViewController(withIdentifier: "StatsViewController") as? UINavigationController
 
        self.present(statsVC!, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //
    }
}

