//
//  textField.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 6/20/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class APTextField : UITextField {
    //    override func becomeFirstResponder() -> Bool {
    //        if (!self.canBecomeFirstResponder) {
    //            return false
    //        }
    //        UIView.animate(withDuration: 0.2) {
    //            super.becomeFirstResponder()
    //        }
    //        return true
    //    }
    
    override func awakeFromNib() {
        self.layer.borderWidth = 1
        self.adjustsFontSizeToFitWidth = true
        self.textColor = .airPollutionGreen
        self.tintColor = .airPollutionGreen
        self.layer.borderColor = UIColor.airPollutionGreen.cgColor
        self.autocapitalizationType = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.bounds.height))
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.airPollutionGreen])
        self.leftViewMode = .always
    }
  
}
