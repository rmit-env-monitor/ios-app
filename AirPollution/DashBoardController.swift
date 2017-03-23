//
//  DashBoardController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import Alamofire
import FoldingCell
import OpenSansSwift


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
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem = logoutButton
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barTintColor = UIColor.black
        navigationBar?.tintColor = UIColor.init(r: 201, g: 251, b: 82)
        _ = OpenSans.registerFonts()
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(r: 201, g: 251, b: 82), NSFontAttributeName : UIFont.openSansLightFontOfSize(18)]
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
    
    //Folding Cell Section
    fileprivate struct C {
        struct CellHeight {
            static let close: CGFloat = 108 // equal or greater foregroundView height
            static let open: CGFloat = 282 // equal or greater containerView height
        }
    }
    
    var itemHeights = (0..<12).map { _ in C.CellHeight.close }

    
}
extension DashBoardController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("Number of data set \(dictionary.count)")
        return itemHeights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dashboardCell") as! DashboardCell
        /*cell.idLabel.text = "Data No.\(indexPath.row + 1)"
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
        }*/
        
        cell.districtLabel.text = "District \(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Just kicking a row")
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Folding Cell Section
        guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        
        var duration = 0
        if itemHeights[indexPath.row] == C.CellHeight.close {
            itemHeights[indexPath.row] = C.CellHeight.open
            cell.selectedAnimation(true, animated: true, completion: nil)
            duration = Int(0.5)
        }
        else {
            itemHeights[indexPath.row] = C.CellHeight.close
            cell.selectedAnimation(false, animated: true, completion: nil)
            duration = Int(1.1)
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveEaseOut, animations: { 
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell {
            if itemHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion: nil)
            }
            else {
                cell.selectedAnimation(true, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeights[indexPath.row]
    }
    
}
