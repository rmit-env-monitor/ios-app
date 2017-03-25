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
    
    var getAuthorized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.navigationItem.title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.gray
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var itemHeights = (0..<12).map { _ in C.CellHeight.close }
    
    
}

fileprivate struct C {
    struct CellHeight {
        static let close: CGFloat = 108
        static let open: CGFloat = 282
    }
}




enum Section : Int {
    case MapCell
    case DistrictCell
    
    init?(indexPath : NSIndexPath) {
        self.init(rawValue: indexPath.row)
    }
    
    
}

extension SmartDashBoardController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        switch Section(indexPath: indexPath as NSIndexPath) {
        //        case .MapCell?:
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
        //            cell.getAuthorized = self.getAuthorized
        //            return cell
        //        case .DistrictCell?:
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell") as! DashboardCell
        //            return cell
        //        case .none:
        //            return UITableViewCell()
        //        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
            cell.getAuthorized = self.getAuthorized
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashboardCell") as! DashboardCell
            cell.districtLabel.font = UIFont.openSansSemiboldFontOfSize(17)
            cell.districtLabel.text = "District \(indexPath.row)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row > 0 {
            let cell = tableView.cellForRow(at: indexPath) as! DashboardCell
            cell.indexPath = indexPath
            cell.delegate = self
            var duration = 0
            cell.districtLabel.alpha = 0
            cell.isUserInteractionEnabled = false
            
            //open the cell
            if itemHeights[indexPath.row - 1] == C.CellHeight.close {
                itemHeights[indexPath.row - 1] = C.CellHeight.open
                cell.selectedAnimation(true, animated: true, completion: { (_) in
                    cell.isUserInteractionEnabled = true
                })
                duration = Int(0.5)
            }
            else {
                //close the cell
                itemHeights[indexPath.row - 1] = C.CellHeight.close
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
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return itemHeights[indexPath.row - 1]
        }
        return self.view.bounds.height - 100
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        switch Section(rawValue: section) {
        //        case .MapCell?:
        //            return 1
        //        case .DistrictCell?:
        //            return 1
        //        case .none:
        //            return 0
        //        }
        return 1 + itemHeights.count
    }
}

extension SmartDashBoardController : DashBoardCellDelegate {
    func didCloseTheFoldingCell(ip: IndexPath) {
        self.tableView(tableView, didSelectRowAt: ip)
    }
}

















