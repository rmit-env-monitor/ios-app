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
    
    var currentLocation : Location?
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "Current Location"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var getAuthorized = false
    
}




enum Section : Int {
    case MapCell
    case DistrictCell
    
    init?(indexPath : NSIndexPath) {
        self.init(rawValue: indexPath.row)
    }
    

}

extension SmartDashBoardController : UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch Section(indexPath: indexPath as NSIndexPath) {
        case .MapCell?:
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
            cell.getAuthorized = self.getAuthorized
            return cell
        case .DistrictCell?:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell") as! DashboardCell
            return cell
        case .none:
            return UITableViewCell()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .MapCell?:
            return 1
        case .DistrictCell?:
            return 1
        case .none:
            return 0
        }
    }
}


















