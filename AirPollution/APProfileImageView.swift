//
//  APProfileImageView.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/23/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import UIKit

class APProfileImageView: UIImageView {
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 51
    }
}
