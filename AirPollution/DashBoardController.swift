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
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.leftBarButtonItem = logoutButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func onLogout() {
        Client.logout()
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchData() {
        Client.loadDashBoard { (response) in
            self.dictionary = response
            print(response)
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var stats = [String : AnyObject]()
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! StatsViewController
        nextVC.stats = Stats(dictionary: stats)
        //pass data next
    }
    
}
extension DashBoardController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of data set \(dictionary.count)")
        return dictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell") as! DashboardCell
        cell.idLabel.text = "Data No.\(indexPath.row + 1)"
        cell.collectorLabel.text = "Collector: " + "Duy"
        stats = dictionary[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss a"
        formatter.timeZone = TimeZone(abbreviation: "GMT+0700")
        if let seconds = dictionary[indexPath.row]["utcDateTime"]?.doubleValue {
            let date = NSDate(timeIntervalSince1970: seconds)
            cell.timeLabel.text = formatter.string(from: date as Date)
        }
        else {
            cell.timeLabel.text = "***"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Just kicking a row")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
}
