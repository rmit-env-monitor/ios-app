//
//  StatsViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/8/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    var stats : Stats? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(stats?.no)
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        self.navigationItem.title = "Statistic"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
