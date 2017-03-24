//
//  PopUpVC.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/10/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

class PopUpVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dashboardCollectionView : UICollectionView!
    var dictionary = Stats(dictionary: [String : AnyObject]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        let nib = UINib(nibName: "PopUpCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PopUpCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: collectionView.bounds.width/2 + 20, height: 90)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
extension PopUpVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
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
        
        switch indexPath.row {
            case 0:
                cell.statsTypeLabel.text = "AQHI"
            case 1:
                cell.statsTypeLabel.text = "NO/NO2"
//                cell.statusButton.titleLabel?.text = dictionary.no as! String
            case 2:
                cell.statsTypeLabel.text = "SO2"
                //cell.statusButton.titleLabel?.text = dictionary.so2 as! String
            case 3:
                cell.statsTypeLabel.text = "PM2.5/PM10"
                //cell.statusButton.titleLabel?.text = dictionary.pm as! String
            case 4:
                cell.statsTypeLabel.text = "O3"
                //cell.statusButton.titleLabel?.text = dictionary.o3 as! String
            case 5:
                cell.statsTypeLabel.text = "Sound"
                //cell.statusButton.titleLabel?.text = dictionary.sound as! String
            default:
                cell.statsTypeLabel.text = "***"
                //cell.statusButton.titleLabel?.text = "NN"
        }
        return cell
        
    }
    
    func setupStatusButton(statsType : String, cell : PopUpCell) {
        
        
    }
    
    
    
    
}
