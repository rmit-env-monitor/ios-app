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
        self.navigationItem.title = "Dashboard"
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(onLogout))
        self.navigationItem.rightBarButtonItem = logoutButton
        self.navigationItem.title = "Home"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = UIColor.gray
        
    }
    
    func onLogout() {
        Client.logout()
        self.dismiss(animated: true, completion: nil)
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
    case mapCell
    case districtCell
    
    init?(indexPath : IndexPath) {
        self.init(rawValue: indexPath.row)
    }
    
    
}

extension SmartDashBoardController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell") as! MapCell
            cell.getAuthorized = self.getAuthorized
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}


















