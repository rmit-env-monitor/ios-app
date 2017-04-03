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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.gray

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
extension DashBoardController : UITableViewDelegate,UITableViewDataSource, DashBoardCellDelegate {
    
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
        cell.districtLabel.font = UIFont.openSansSemiboldFontOfSize(17)
        cell.districtLabel.text = "District \(indexPath.row + 1)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Folding Cell Section
        guard case let cell as DashboardCell = tableView.cellForRow(at: indexPath) else {
            return
        }
        cell.indexPath = indexPath
        cell.delegate = self
        var duration = 0
        cell.districtLabel.alpha = 0
        cell.isUserInteractionEnabled = false

        //open the cell
        if itemHeights[indexPath.row] == C.CellHeight.close {
            itemHeights[indexPath.row] = C.CellHeight.open
            cell.selectedAnimation(true, animated: true, completion: { _ in
              cell.isUserInteractionEnabled = true
            })
            duration = Int(0.5)
        }
        //close the cell
        else {
            itemHeights[indexPath.row] = C.CellHeight.close
            cell.selectedAnimation(false, animated: true, completion: { _ in
                cell.isUserInteractionEnabled = true
            })
            duration = Int(1.1)
        }
        
        UIView.animate(withDuration: TimeInterval(duration), delay: 0, options: .curveEaseOut, animations: {
            tableView.beginUpdates()
            tableView.endUpdates()
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                cell.districtLabel.alpha = 1
            })
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if case let cell as FoldingCell = cell {
            if itemHeights[indexPath.row] == C.CellHeight.close {
                cell.selectedAnimation(false, animated: false, completion:nil)
            } else {
                cell.selectedAnimation(true, animated: false, completion: nil)
            }
        }
    }
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return itemHeights[indexPath.row]
    }
    
    func didCloseTheFoldingCell(_ ip: IndexPath) {
        self.tableView(self.tableView, didSelectRowAt: ip)
    }
}
