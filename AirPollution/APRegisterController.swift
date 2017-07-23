//
//  APRegisterController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/1/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import PKHUD

protocol APRegisterControllerDelegate: class {
    func didFinishSignUp(username: String, password: String)
}

class APRegisterController: UIViewController {
    
    @IBOutlet weak var logoImageView: APProfileImageView!
    @IBOutlet weak var usernameTextField: APTextField!
    @IBOutlet weak var passwordTextField: APTextField!
    @IBOutlet weak var confirmTextField: APTextField!
    
    var termViewController: UIViewController?
    weak var delegate: APRegisterControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 51
        let backButton = UIButton(frame: CGRect(x: 30, y: 30, width: 30, height: 30))
        backButton.setImage(greenBackIcon!, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
}

// MARK: Handle button events
extension APRegisterController {
    @IBAction func signInButtonPressed(_ sender: Any) {
        self.delegate?.didFinishSignUp(username: usernameTextField.text!, password: passwordTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func termOfServiceButtonPressed(_ sender: Any) {
        self.termViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: self.termViewController!)
        self.termViewController?.view.backgroundColor = UIColor.white
        self.termViewController?.navigationItem.title = "Term Of Services"
        let backButton = UIBarButtonItem(image: backIcon!, style: .plain, target: self, action: #selector(backButtonPressed))
        self.termViewController?.navigationItem.leftBarButtonItem = backButton
        self.termViewController?.navigationItem.leftBarButtonItem?.tintColor = .white
        let scrollView = UIScrollView(frame: CGRect(x: 30, y: 30, width: self.view.bounds.width - 60, height: self.view.bounds.height - 60))
        self.termViewController?.view.addSubview(scrollView)
        let contentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: scrollView.bounds.height))
        scrollView.addSubview(contentLabel)
        scrollView.isScrollEnabled = true
        contentLabel.text = sampleText
        contentLabel.textAlignment = .justified
        contentLabel.numberOfLines = 0
        contentLabel.sizeToFit()
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: contentLabel.frame.height)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        HUD.show(.progress)
        guard let username = usernameTextField.text, let password = passwordTextField.text, let confirmPassword = passwordTextField.text else { return }
        if password != confirmPassword { APUltils.presentAlertController(title: "Passwords Does Not Match!") { }; return }
        let params : [String: String] = ["username": username, "password": password]
        Client.register(params) { (response) in
            HUD.hide()
            if response == "" {
                APUltils.presentAlertController(title: "Register Successfully!") { [weak self] in
                    guard let weakSelf = self else { return }
                    weakSelf.dismiss(animated: true, completion: nil)
                }
            } else {
                APUltils.presentAlertController(title: response) { }
            }
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate dynamic func backButtonPressed() {
        if termViewController != nil {
            self.termViewController?.dismiss(animated: true, completion: nil)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
