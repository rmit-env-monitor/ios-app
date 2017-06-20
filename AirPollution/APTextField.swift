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
    
    init(placeHolder: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSForegroundColorAttributeName: UIColor.airPollutionGreen])
        self.font = UIFont.getFutura(fontSize: 14)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.white
        self.tintColor = UIColor.airPollutionGreen
        self.textColor = UIColor.airPollutionGreen
        self.borderStyle = .line
        self.layer.borderWidth = 1
        self.adjustsFontSizeToFitWidth = true
        self.layer.borderColor = UIColor.airPollutionGreen.cgColor
        self.autocapitalizationType = .none
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.bounds.height))
        self.leftViewMode = .always
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
