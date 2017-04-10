//
//  StatsViewCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/11/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import GTProgressBar


class StatsViewCell: UITableViewCell {
        
    @IBOutlet weak var progressBar: GTProgressBar!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupProgressBar()

    }
    
    func setupProgressBar() {
        
        progressBar.barBorderColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barFillColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.barBackgroundColor = UIColor(red:0.77, green:0.93, blue:0.78, alpha:1.0)
        progressBar.barBorderWidth = 1
        progressBar.barFillInset = 0
        progressBar.labelTextColor = UIColor(red:0.35, green:0.80, blue:0.36, alpha:1.0)
        progressBar.progressLabelInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        progressBar.barMaxHeight = 12
        DispatchQueue.main.async { [weak self] in
            self?.progressBar.animateTo(progress: 0.66)
        }
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}


