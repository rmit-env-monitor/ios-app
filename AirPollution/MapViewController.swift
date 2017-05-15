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
import PKHUD


class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupSearchBarUI()
        HUD.show(.progress)
        mapView.delegate = self
        self.navigationItem.title = "Map"
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchLocationController : UISearchController!
    
    func showAnnotation() {
        if let currentLocation = Client.userDefaults.object(forKey: currentAddressKey) as? [String : AnyObject] {
           
            let lat  = currentLocation["latitude"] as! Double
            let lon  = currentLocation["longitude"] as! Double
            
            let location = CLLocationCoordinate2DMake(lat, lon)
            let annotation = MKPointAnnotation()
         
            annotation.coordinate = location
            
            var annotations = [MKPointAnnotation]()
            var coordinations = [CLLocationCoordinate2D]()
            
            
            //Nha Be
            coordinations.append(CLLocationCoordinate2DMake(Double(10.691720), Double(106.718758)))
            
            //Quan 2
            coordinations.append(CLLocationCoordinate2DMake(Double(10.773778), Double(106.719569)))
            
            //Quan 4
            coordinations.append(CLLocationCoordinate2DMake(Double(10.756656), Double(106.700965)))
            
            //Quan 8
            coordinations.append(CLLocationCoordinate2DMake(Double(10.739984), Double(106.670370)))
            annotations.append(annotation)
            
            for i in 0...3 {
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinations[i]
                annotations.append(annotation)
            }
            
            for annotation in annotations {
                annotation.title = "District : Quận abcxyz"
                annotation.subtitle = "AQHI: 0"
            }
            mapView.showAnnotations(annotations, animated: true)
            
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
            
       
            
            //we need a variable holding the AQI value used to decide which color the annotationView will be
            annotationView!.image = lowAQIAnnotationView!
            let aqhiLabel = UILabel(frame: CGRect(x: 2.5, y: -5, width: annotationView!.image!.size.width - 5, height: annotationView!.image!.size.height))
            
            aqhiLabel.text = "0"
            aqhiLabel.textAlignment = .center
            aqhiLabel.font = UIFont(name: "Futura", size: 13)
            aqhiLabel.textColor = UIColor.black
            annotationView!.addSubview(aqhiLabel)
        }
        //if it exits, update the annotation object of the dequeued annotation View
        else {
            annotationView!.annotation = annotation
        }
        
        
        
        
        return annotationView
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
       HUD.hide()
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        showAnnotation()
    }
    
    func handleOpenDetailView() {
        let statsVC = storyBoard.instantiateViewController(withIdentifier: "StatsViewController") as? UINavigationController
 
        self.present(statsVC!, animated: true, completion: nil)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        //
    }
}

