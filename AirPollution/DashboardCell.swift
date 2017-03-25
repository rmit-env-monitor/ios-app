//
//  dashboardCell.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import FoldingCell
import OpenSansSwift


@objc protocol DashBoardCellDelegate {
    func didCloseTheFoldingCell(ip : IndexPath)
}


class DashboardCell: FoldingCell {
    
    //    @IBOutlet weak var timeLabel: UILabel!
    //
    //    @IBOutlet weak var idLabel: UILabel!
    //
    //    @IBOutlet weak var collectorLabel: UILabel!
    
    @IBOutlet weak var bbForegroundView: RotatedView!
    
    @IBOutlet weak var bbContainerView: UIView!
    
    @IBOutlet weak var districtLabel: UILabel!
    
    @IBOutlet weak var detailBackgroundView: UIView!
    
    @IBOutlet weak var foregroundBackgroundView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate : DashBoardCellDelegate?
    
    var indexPath : IndexPath?
    
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
        setupUI()
        configureCollectionView()
    }
    
    func setupUI() {
        bbForegroundView.backgroundColor = UIColor.clear
        self.backViewColor = UIColor.lightGray
        bbContainerView.backgroundColor = UIColor.clear
        foregroundBackgroundView.backgroundColor = UIColor.white
        foregroundBackgroundView.layer.cornerRadius = 5
        detailBackgroundView.layer.cornerRadius = 5
        detailBackgroundView.backgroundColor = UIColor.white
        self.backgroundColor = UIColor.gray
        
        
        
    }
    
    func configureCollectionView() {
        //setup the collectionView
        let nib = UINib(nibName: "PopUpCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PopUpCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: collectionView.bounds.width/2 + 20, height: 90)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        _ = OpenSans.registerFonts()
        collectionView.collectionViewLayout = layout
        
        //add gesture on collection view to close the cell
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeCell))
        collectionView.addGestureRecognizer(tap)
    }
    
    override func prepareForReuse() {
        //å
    }
    
    
    func closeCell() {
        delegate?.didCloseTheFoldingCell(ip: self.indexPath!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension DashboardCell : UICollectionViewDelegate, UICollectionViewDataSource {
    //comform collectionView datasource functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TO DO : next
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopUpCell", for: indexPath) as! PopUpCell
        //var type = ""
        
        let statsTypeLabels = ["AQHI","NO/NO2","SO2","PM2.5/10","O3","Sound","***"]
        
        cell.statsTypeLabel.font = UIFont.openSansSemiboldFontOfSize(12)
        cell.statsTypeLabel.text = statsTypeLabels[indexPath.row]
        return cell
    }
}
