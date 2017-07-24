//
//  APViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/24/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class APViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let progressView = APCircularProgressBar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        progressView.center = self.view.center
        self.view.addSubview(progressView)
    }
}
