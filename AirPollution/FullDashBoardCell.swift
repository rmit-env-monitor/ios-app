//
//  FullDashBoardCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/11/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class FullDashBoardCell: UITableViewCell {

    @IBOutlet weak var districtLabel: UILabel!
    
    @IBOutlet weak var aqhiLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


