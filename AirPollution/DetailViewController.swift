//
//  DetailViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var navigationTitle : String? {
        didSet {
            self.navigationItem.title = navigationTitle!
        }
    }
    var sensors = [Sensor]()
    @IBOutlet weak var tableView: UITableView!
    
    var city : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        fetchSensors()
    }
    
    func fetchSensors() {
        weak var selfRefer = self
        Client.getSensorsByDistricts(navigationTitle!, city) { (sensors) in
            if sensors != nil {
                selfRefer?.sensors = sensors!
                selfRefer?.tableView.reloadData()
            }
        }
    }
    
    


}

//MARK : setup table view
extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell") as! DetailViewCell
        cell.sensorNo.text = sensors[indexPath.row].name!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sensors"
    }
}
