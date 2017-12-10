//
//  APCircularProgressBar.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/24/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import UICircularProgressRing
class APCircularProgressBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let nib = UINib(nibName: "APCircularProgressBar", bundle: nil)
        let progressView = nib.instantiate(withOwner: self, options: nil)[0] as! UICircularProgressRingView
        progressView.frame = self.bounds
        self.addSubview(progressView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
