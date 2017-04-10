//
//  DetailViewCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class DetailViewCell: UITableViewCell {
    
    @IBOutlet weak var sensorNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
