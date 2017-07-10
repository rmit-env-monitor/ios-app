//
//  APLoginController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 6/29/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

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
        setupLogoUI()
        setupFBButtonUI()
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
    
    fileprivate func setupLogoUI() {
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 51
    }
    
    fileprivate func setupFBButtonUI() {
        let facebookLogo = UIImageView(frame: CGRect(x: loginWithFBButton.bounds.width - 50, y: 0, width: 43, height: 45))
        facebookLogo.image = UIImage(named: "Facebook-Icon")
        facebookLogo.contentMode = .scaleToFill
        loginWithFBButton.addSubview(facebookLogo)
    }
    
    @IBAction func onTabGesture(_ sender: Any) {
        self.view.endEditing(true)
    }
}

// MARK: - Handle Button Events
extension APLoginController {
    @IBAction func signInButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        let params: [String: Any] = ["username": username, "password": password]
        Client.login(params) { (success) in
            if success == false {
                let alertViewController = UIAlertController(title: "Login Failed", message: "Wrong username or password!", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                    alertViewController.dismiss(animated: true, completion: nil)
                }
                alertViewController.addAction(okAction)
                self.present(alertViewController, animated: true, completion: nil)
            } else {
                self.view.endEditing(true)
                let popUpView = APPopUpView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 50, height: self.view.bounds.height / 2))
                popUpView.delegate = self
                popUpView.center = self.view.center
                self.view.addSubview(popUpView)
            }
        }
    }
}

// MARK: - APPopUpViewDelegate
extension APLoginController: APPopUpViewDelegate {
    func okButtonTapped() {
        self.performSegue(withIdentifier: "Show Tab Bar Controller", sender: nil)
    }
}
