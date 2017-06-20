//
//  PopUpViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/3/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit


enum locationMethod {
    case manually
    case automatically
    case none
}

protocol PopUpViewControllerDelegate : class {
    func getCurrentLocation(method : locationMethod)
}

class PopUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    weak var delegate : PopUpViewControllerDelegate?
    
    lazy var inputLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.attributedText = NSAttributedString(string: "Could you tell us where you are now?", attributes: [NSFontAttributeName : UIFont.getFutura(fontSize: 18)])
        lb.textAlignment = .center
        lb.numberOfLines = 0
        print("HeRe")
        return lb
    }()
    
    lazy var buttonContainer : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var automaticButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Automatically detect my location", for: .normal)
        btn.titleLabel?.font = UIFont.getFutura(fontSize: 14)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.addTarget(self, action: #selector(handleDetectLocationAutomatically), for: .touchUpInside)
        return btn
    }()
    
    lazy var manuallyButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("My location is...", for: .normal)
        btn.titleLabel?.font = UIFont.getFutura(fontSize: 14)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.addTarget(self, action: #selector(handleDetectLocationManually), for: .touchUpInside)
        return btn
    }()
    
    lazy var cancelButton : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cancel", for: .normal)
        btn.titleLabel?.font = UIFont.getFutura(fontSize: 14)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.black, for: .highlighted)
        btn.addTarget(self, action: #selector(handleCancelDetectLocation), for: .touchUpInside)
        return btn
    }()
    
    lazy var secondSeparatorLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.gray
        return lb
    }()
    
    lazy var firstSeparatorLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.gray
        return lb
    }()
    
    lazy var thirdSeparatorLable : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.backgroundColor = UIColor.gray
        return lb
    }()
    
}

//MARK : set up function for buttons
extension PopUpViewController {
    func handleDetectLocationAutomatically(sender : UIButton) {
        self.delegate?.getCurrentLocation(method: .automatically)
    }
    
    func handleDetectLocationManually(sender : UIButton) {
        self.delegate?.getCurrentLocation(method: .manually)
    }
    
    func handleCancelDetectLocation() {
        self.delegate?.getCurrentLocation(method: .none)
    }
    
    
}

//MARK : set up constraints for this VC
extension PopUpViewController {
    func setupUI() {
        view.addSubview(inputLabel)
        view.addSubview(buttonContainer)
        
        inputLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -8).isActive = true
        inputLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        inputLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        inputLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        buttonContainer.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 30).isActive = true
        buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        buttonContainer.addSubview(automaticButton)
        buttonContainer.addSubview(manuallyButton)
        buttonContainer.addSubview(secondSeparatorLabel)
        buttonContainer.addSubview(firstSeparatorLabel)
        buttonContainer.addSubview(thirdSeparatorLable)
        buttonContainer.addSubview(cancelButton)
        
        firstSeparatorLabel.topAnchor.constraint(equalTo: buttonContainer.topAnchor).isActive = true
        firstSeparatorLabel.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        firstSeparatorLabel.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        firstSeparatorLabel.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        automaticButton.topAnchor.constraint(equalTo: firstSeparatorLabel.bottomAnchor).isActive = true
        automaticButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        automaticButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 1/3).isActive = true
        automaticButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        
        secondSeparatorLabel.topAnchor.constraint(equalTo: automaticButton.bottomAnchor).isActive = true
        secondSeparatorLabel.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        secondSeparatorLabel.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        secondSeparatorLabel.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        manuallyButton.topAnchor.constraint(equalTo: secondSeparatorLabel.bottomAnchor).isActive = true
        manuallyButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        manuallyButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 1/3).isActive = true
        manuallyButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        
        thirdSeparatorLable.topAnchor.constraint(equalTo: manuallyButton.bottomAnchor).isActive = true
        thirdSeparatorLable.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor).isActive = true
        thirdSeparatorLable.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        thirdSeparatorLable.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: thirdSeparatorLable.bottomAnchor).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: thirdSeparatorLable.leftAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 1/3).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: buttonContainer.widthAnchor).isActive = true
        
    }
}
