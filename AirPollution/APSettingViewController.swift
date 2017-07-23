//
//  APSettingViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/23/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

enum SettingTitle: Int  {
    case editLocation = 0
    case information
    case changePassword
    case termOfServices
    case aboutUs
}

class APSettingViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let cellID = "Setting Table View Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
    }
    
    fileprivate func setupUI() {
        let button = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.rightBarButtonItem = button
    }
    
    fileprivate func setupTableView() {
        tableView.isScrollEnabled = false
        let cell = UINib(nibName: "APSettingTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: cellID)
    }
    
    @IBAction fileprivate func LogOutTapped(_ sender: Any) { }
}

//MARK: - UITableViewDelegate 
extension APSettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.height - 30) / 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! APSettingTableViewCell
        guard let settingTitle = SettingTitle(rawValue: indexPath.section) else { return UITableViewCell() }
        switch settingTitle {
        case .aboutUs:
            cell.titleLabel.text = "About Us"
        case .changePassword:
            cell.titleLabel.text = "Change Password"
            cell.accessoryType = .disclosureIndicator
        case .editLocation:
            cell.titleLabel.text = "Edit Location"
            cell.accessoryType = .disclosureIndicator
        case .information:
            cell.titleLabel.text = "Information"
            cell.accessoryType = .disclosureIndicator
        case .termOfServices:
            cell.titleLabel.text = "Term Of Services"
        }
        return cell
    }
}
