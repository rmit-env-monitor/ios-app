
//
//  mapCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/25/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import MapKit

class MapCell: UITableViewCell {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var getAuthorized : Bool? {
        didSet {
            //mapView.showsUserLocation = getAuthorized!
        }
    }

    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


extension MapCell : CLLocationManagerDelegate {
    
}
