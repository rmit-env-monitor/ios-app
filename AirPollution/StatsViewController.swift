//
//  StatsViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/11/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let sectionTitles = ["o3" , "sound" , "pm" , "so2", "no"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "Statistic"
        let leftNavigationBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(backToDetailVC))
        self.navigationItem.leftBarButtonItem = leftNavigationBarButton
        // Do any additional setup after loading the view.
    }
    
    func backToDetailVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



//MARK : set up table view
extension StatsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatsViewCell") as! StatsViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let cell = tableView.cellForRow(at: indexPath) as! StatsViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}
