//
//  APRegisterController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 7/1/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit

protocol APRegisterControllerDelegate: class {
    func didFinishSignUp(username: String, password: String)
}

class APRegisterController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
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
        setupLogo()
        setupBackButton()
    }
    
    func setupLogo() {
        logoImageView.clipsToBounds = true
        logoImageView.layer.cornerRadius = 51
    }
    
    func setupBackButton() {
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
    
    func backButtonPressed() {
        if termViewController != nil {
            self.termViewController?.navigationController?.popViewController(animated: true)
            self.termViewController?.dismiss(animated: true) { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.termViewController = nil
            }
        } else { 
            self.dismiss(animated: true, completion: nil)
        }
    }

    
}
