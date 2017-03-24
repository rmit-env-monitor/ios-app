//
//  PopUpCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class PopUpCell: UICollectionViewCell {

    @IBOutlet weak var statsTypeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    func setupUI() {
        self.contentView.backgroundColor = UIColor.clear
    }

}
