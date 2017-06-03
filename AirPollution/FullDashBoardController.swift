//
//  FullDashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/11/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit



class FullDashBoardController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Dashboard"
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var toDetailDistrict : String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromFullDashBoardSegue" {
            let destinationViewController = segue.destination as! DetailViewController
            destinationViewController.navigationTitle = toDetailDistrict
            destinationViewController.city = "Hồ Chí Minh"
        }
    }

}

//MARK : set up table view
extension FullDashBoardController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return districtsInHCM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FullDashBoardCell") as! FullDashBoardCell
        cell.aqhiLabel.text = "AQHI: 0"
        cell.districtLabel.text = districtsInHCM[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! FullDashBoardCell
        toDetailDistrict = cell.districtLabel.text!
        performSegue(withIdentifier: "FromFullDashBoardSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Districts"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}
