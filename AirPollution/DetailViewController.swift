//
//  DetailViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import PKHUD

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
        Client.getSensorsByDistricts(District: navigationTitle!, city) { [unowned self](sensors)  in
            
            if sensors != nil {
                if sensors!.isEmpty {
                    let alertController = UIAlertController(title: nil, message: "There is no sensors in this district", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        alertController.dismiss(animated: true, completion: nil)
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController,animated: true, completion: nil)
                }
                self.sensors = sensors!
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToStatsViewSegue" {
            //let destinationViewController = segue.destination as! StatsViewController
            
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
        cell.sensorNo.text = "Sensor: \(sensors[indexPath.row].name!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ToStatsViewSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sensors"
    }
}
