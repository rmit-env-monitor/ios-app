//
//  StatsViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/8/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit
import PopupDialog

class StatsViewController: UIViewController {
    var stats = Stats(dictionary: [String : AnyObject]())
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMap()
        print(stats)
    }
    
    func setupMap() {
       // let latitude = CLLocationDegrees(stats.latitude!)
        //let longitude = CLLocationDegrees(stats.longitude!)
        mapView.delegate = self
        let initialLocation = CLLocation(latitude: 10.729440, longitude: 106.695952)
        centerMapOnLocation(initialLocation)
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "This is my annotation"
        mapView.addAnnotation(annotation)
    }
    
    func centerMapOnLocation(_ location : CLLocation) {
        let regionRadius : CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
       
    }
    
    func setupUI() {
        self.navigationItem.title = "Statistic"
    }


}

extension StatsViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Pin"
        
        if annotation is MKPointAnnotation {
          
                let annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifier)
                annotationView.isEnabled = true
                annotationView.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
            
                return annotationView
            
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Click Annotation")
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Click Accessory")
        let popUpVC = PopUpVC(nibName: "PopUpVC", bundle: nil)
        
        popUpVC.dictionary = self.stats
        let popUp = PopupDialog(viewController: popUpVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true, completion: nil)
        
        let buttonOne = CancelButton(title: "Cancel") {
            print("Tap cancel")
        }
        
        popUp.addButton(buttonOne)
        present(popUp, animated: true, completion: nil)
        //TO DO: Pop up a view and show the stats
    }
    
    
}
