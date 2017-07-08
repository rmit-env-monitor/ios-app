//
//  APLoginController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 6/29/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import SIAlertView

class APLoginController: UIViewController {
    
    @IBOutlet weak var usernameTextField: APTextField!
    @IBOutlet weak var passwordTextField: APTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginWithFBButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupLogoUI()
        setupFBButtonUI()
    }
    
    func setupLogoUI() {
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 51
    }
    
    func setupFBButtonUI() {
        let facebookLogo = UIImageView(frame: CGRect(x: loginWithFBButton.bounds.width - 50, y: 0, width: 43, height: 45))
        facebookLogo.image = UIImage(named: "Facebook-Icon")
        facebookLogo.contentMode = .scaleToFill
        loginWithFBButton.addSubview(facebookLogo)
    }
    
}

// MARK: - Handle Button Events
extension APLoginController {
    @IBAction func signInButtonPressed(_ sender: Any) {
        if let username = usernameTextField.text, let password = passwordTextField.text {
            let params: [String: Any] = ["username": username, "password": password]
            Client.login(params) { (success) in
                if success == false {
                    let alertView = SIAlertView(title: "Warning", andMessage: "Wrong username or password")
                    alertView?.addButton(withTitle: "OK", type: .default) { (alertView) in
                        alertView?.dismiss(animated: true)
                    }
                    alertView?.show()
                } else {
                    let popUpView = APPopUpView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2))
                    popUpView.delegate = self
                    popUpView.center = self.view.center
                    self.view.addSubview(popUpView)
                }
            }
            
        }
        
    }
}

// MARK: - APPopUpViewDelegate
extension APLoginController: APPopUpViewDelegate {
    func okButtonTapped() {
        // handel button event
    }
}
