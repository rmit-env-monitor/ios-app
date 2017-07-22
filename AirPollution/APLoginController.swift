//
//  APLoginController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 6/29/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import PKHUD

class APLoginController: UIViewController {
    
    @IBOutlet weak var usernameTextField: APTextField!
    @IBOutlet weak var passwordTextField: APTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var loginWithFBButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoTopLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNotificationCenter()
    }
    
    fileprivate func setupUI() {
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 51
        let facebookLogo = UIImageView(frame: CGRect(x: loginWithFBButton.bounds.width - 50, y: 0, width: 43, height: 45))
        facebookLogo.image = UIImage(named: "Facebook-Icon")
        facebookLogo.contentMode = .scaleToFill
        loginWithFBButton.addSubview(facebookLogo)
    }
    
    fileprivate func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: Notification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    fileprivate dynamic func keyboardDidHide() {
        logoTopLayoutConstraint.constant = 54
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    fileprivate dynamic func keyboardDidShow() {
        logoTopLayoutConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func onTabGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
}

// MARK: - Handle Button Events
extension APLoginController {
    @IBAction func signInButtonPressed(_ sender: Any) {
        self.view.endEditing(true)
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        let params: [String: Any] = ["username": username, "password": password]
        HUD.show(.progress)
        Client.login(params) { (response) in
            if let errorMessage = response["message"] {
                APUltils.presentAlertController(title: "Login Failed", message: errorMessage, completionHandler: { })
            } else {
                Client.currentUser = User(dictionary: response)
                userDefaults.set(response["token"], forKey: USERTOKEN)
                let popUpView = APPopUpView(frame: CGRect(x: 0, y: self.view.bounds.height, width: 294, height: 297))
                popUpView.delegate = self
                self.view.addSubview(popUpView)
                popUpView.center.x = self.view.center.x
                UIView.animate(withDuration: 0.2) { popUpView.center.y = self.view.center.y }
            }
            HUD.hide()
        }
    }
}

// MARK: - APPopUpViewDelegate
extension APLoginController: APPopUpViewDelegate {
    func cancelButtonTapped() { }

    func okButtonTapped() {
        self.performSegue(withIdentifier: "Show Tab Bar Controller", sender: nil)
    }
}
