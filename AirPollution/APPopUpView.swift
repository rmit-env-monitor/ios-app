//
//  APPopUpView.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/5/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

protocol APPopUpViewDelegate: class {
    func okButtonTapped()
    func cancelButtonTapped()
}

final class APPopUpView: UIView {
    
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    
    weak var delegate: APPopUpViewDelegate?
    let enableCheckBoxImage = UIImage(named: "enable-checkbox-button")
    let unableCheckboxImage = UIImage(named: "unable-checkbox-button")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        instanceFromNib()
    }
    
    @IBAction func firstChoiceButtonTapped(_ sender: Any) {
        setupButtonWhenTapped(button: firstChoiceButton)
    }
    
    @IBAction func secondChoiceButtonTapped(_ sender: Any) {
        setupButtonWhenTapped(button: secondChoiceButton)
    }
    
    @IBAction func thirdChoiceButtonTapped(_ sender: Any) {
        setupButtonWhenTapped(button: thirdChoiceButton)
    }

    @IBAction func okButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: { 
            self.removeFromSuperview()
        }) { (success) in
            self.delegate?.okButtonTapped()
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.removeFromSuperview()
        self.delegate?.cancelButtonTapped()
    }
    
    fileprivate func setupButtonWhenTapped(button: UIButton) {
        if button == firstChoiceButton {
            firstChoiceButton.setImage(enableCheckBoxImage, for: .normal)
            secondChoiceButton.setImage(unableCheckboxImage, for: .normal)
            thirdChoiceButton.setImage(unableCheckboxImage, for: .normal)
        } else if button == secondChoiceButton {
            firstChoiceButton.setImage(unableCheckboxImage, for: .normal)
            secondChoiceButton.setImage(enableCheckBoxImage, for: .normal)
            thirdChoiceButton.setImage(unableCheckboxImage, for: .normal)
        } else if button == thirdChoiceButton {
            firstChoiceButton.setImage(unableCheckboxImage, for: .normal)
            secondChoiceButton.setImage(unableCheckboxImage, for: .normal)
            thirdChoiceButton.setImage(enableCheckBoxImage, for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func instanceFromNib() {
        let popUpView = UINib(nibName: "APPopUpView", bundle: nil).instantiate(withOwner: self, options: nil).first as! UIView
        self.addSubview(popUpView)
        popUpView.frame = self.bounds
    }
}

