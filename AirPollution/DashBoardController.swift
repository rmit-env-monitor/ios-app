//
//  DashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import Alamofire

class DashBoardController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dictionary = [[String : AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "Dashboard"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func fetchData() {
        Client.loadDashBoard { (response) in
            self.dictionary = response
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension DashBoardController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of data set \(dictionary.count)")
        return dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell") as! DashboardCell
        cell.idLabel.text = "\(indexPath.row)"
        cell.collectorLabel.text = Client.currentUser?.name
        cell.timeLabel.text = "***"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Just kicking a row")
    }

    
}
