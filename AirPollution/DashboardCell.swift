//
//  dashboardCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import FoldingCell
class DashboardCell: FoldingCell {

//    @IBOutlet weak var timeLabel: UILabel!
//    
//    @IBOutlet weak var idLabel: UILabel!
//    
//    @IBOutlet weak var collectorLabel: UILabel!
    
    @IBOutlet weak var bbForegroundView: RotatedView!
 
    @IBOutlet weak var bbContainerView: UIView!
    
    @IBOutlet weak var districtLabel: UILabel!
    
    
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
    override public var foregroundView: RotatedView! {
        get {
            return bbForegroundView
        }
        set {
            //do nothing
        }
    }
    
    override public var containerView: UIView! {
        get {
            return bbContainerView
        }
        set {
            //do nothing
        }
    }
    
    @IBOutlet weak var bbContainerViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var bbForegroundViewTop: NSLayoutConstraint!
    
    override public var containerViewTop: NSLayoutConstraint! {
        get {
            return bbContainerViewTop
        }
        set {
            //do nothing
        }
    }
    
    override public var foregroundViewTop: NSLayoutConstraint! {
        get {
            return bbForegroundViewTop
        }
        set {
            //do nothing
        }
    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
