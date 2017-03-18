//
//  ViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import Alamofire
import ESTabBarController_swift
import OpenSansSwift
import TextFieldEffects
class LoginController: UIViewController {
    
    
    lazy var appNameLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "AIR POLLUTION"
        lb.textAlignment = .center
        
        _ = OpenSans.registerFonts()
        lb.font = UIFont.openSansLightFontOfSize(45)
        lb.textColor = UIColor.gray
        lb.attributedText = NSAttributedString(string: "AIR POLLUTION", attributes: [NSStrokeColorAttributeName: UIColor.black,
            NSStrokeWidthAttributeName: -1])
        return lb
    }()
    
    lazy var nameTextField : YoshikoTextField = {
        let tf = YoshikoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .gray
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.placeholder = "USERNAME"
        tf.placeholderColor = .black
        tf.layer.cornerRadius = 40
        return tf
    }()
    
    lazy var pwTextField : YoshikoTextField = {
        let tf = YoshikoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .gray
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.placeholder = "USERNAME"
        tf.placeholderColor = .black
        tf.layer.cornerRadius = 40
        return tf
    }()
    
    lazy var loginBtn : UIButton = {
        var btn = UIButton()
        btn.titleLabel?.text = "Login"
        
        
        return btn
    }()
    
    lazy var registerBtn : UIButton = {
        
        
        return UIButton()
    }()
    
    
    
    
    
    lazy var bgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loginbg")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func setupUI() {
        view.addSubview(bgImageView)
        view.addSubview(appNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(pwTextField)
        
        appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        appNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        appNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 200).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        pwTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20).isActive = true
        pwTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pwTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if let dictionary = Client.userDefaults.dictionary(forKey: "CurrentUser") {
            Client.currentUser = User(dictionary: dictionary as [String : AnyObject])
            self.present(getToTabBarController(), animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func onLogin() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        Client.login(params: params as [String : AnyObject]) { (isFinished) in
            if (isFinished) {
                self.present(self.getToTabBarController(), animated: true, completion: nil)
            }
        }
    }
    
    func getToTabBarController() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let dashBoardVC = storyboard.instantiateViewController(withIdentifier: "DashBoardController") as! DashBoardController
        let v2 = UIViewController()
        let v3 = UIViewController()
        let v4 = UIViewController()
        
        if let tabBar = tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
            tabBar.backgroundColor = UIColor.black
        }
        
        dashBoardVC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"), tag: 1)
        v2.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Nearby", image: UIImage(named: "currentlocation"), selectedImage: UIImage(named: "currentlocation"), tag: 2)
        v3.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Routing", image: UIImage(named: "routing"), selectedImage: UIImage(named: "routing"), tag: 3)
        v4.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"), tag: 4)
        
        let dashBoardNC = UINavigationController(rootViewController: dashBoardVC)
        
        tabBarController.viewControllers = [dashBoardNC,v2,v3,v4]
        return tabBarController
    }
    
    
    //Register event
    func onRegister() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        Client.register(params: params as [String : AnyObject]) { (isFinished) in
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            if (isFinished) {
                alertController.title = "You have registered successfully"
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                alertController.title = "An unknown error occurs or username has been taken:("
                self.present(alertController, animated: true, completion: nil)
                
            }
        }
    }
}

