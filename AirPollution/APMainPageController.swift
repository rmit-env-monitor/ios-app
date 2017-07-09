//
//  APMainPageController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/9/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class APMainPageController: UIViewController {
    
    fileprivate var mapContainerView: APMapContainerViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.mapContainerView?.requestLocationPermission(presentingViewController: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? APMapContainerViewController, segue.identifier == "Container Map View" {
            self.mapContainerView = viewController
        }
    }
}
