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
    
    /*lazy var appNameLabel : UILabel = {
     let lb = UILabel()
     lb.translatesAutoresizingMaskIntoConstraints = false
     lb.text = "AIR POLLUTION"
     lb.textAlignment = .center
     
     _ = OpenSans.registerFonts()
     lb.font = UIFont.openSansBoldFontOfSize(45)
     lb.textColor = UIColor.white
     lb.attributedText = NSAttributedString(string: "AIR POLLUTION", attributes: [NSStrokeColorAttributeName: UIColor.black,
     NSStrokeWidthAttributeName: -1])
     return lb
     }()*/
    
    lazy var nameTextField : YoshikoTextField = {
        let tf = YoshikoTextField()
        tf.font = UIFont.openSansLightFontOfSize(20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .white
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.placeholder = "USERNAME"
        tf.placeholderColor = .black
        tf.autocapitalizationType = .none
        tf.layer.cornerRadius = 40
        return tf
    }()
    
    lazy var pwTextField : YoshikoTextField = {
        let tf = YoshikoTextField()
        tf.font = UIFont.openSansLightFontOfSize(20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .white
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.placeholder = "PASSWORD"
        tf.autocapitalizationType = .none
        tf.placeholderColor = .black
        return tf
    }()
    
    lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.titleLabel?.font = UIFont.openSansLightFontOfSize(16)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(r: 255, g: 102, b: 102)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return btn
    }()
    
    /*lazy var registerBtn : UIButton = {
     let btn = UIButton()
     btn.translatesAutoresizingMaskIntoConstraints = false
     btn.setTitle("Register", for: .normal)
     btn.backgroundColor = UIColor.gray
     btn.layer.cornerRadius = 20
     btn.layer.masksToBounds = true
     btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
     btn.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
     return btn
     }()*/
    
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
    
    var nameTextFieldTopAnchor : NSLayoutConstraint?
    var bgImageViewTopAnchor : NSLayoutConstraint?
    var loginBtnBottomAnchor : NSLayoutConstraint?
    
    func dismissKeyboard() {
        
        if nameTextField.isFirstResponder {
            UIView.animate(withDuration: 0.5, animations: { 
                self.nameTextField.resignFirstResponder()
            })
        }
        else if pwTextField.isFirstResponder {
            UIView.animate(withDuration: 0.5, animations: {
                self.pwTextField.resignFirstResponder()
            })
        }
        
        
    }
    
    func setupUI() {
        //hint: add observer when keyboard appears to handle UI resizing
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardDidShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardDidHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //hint: add tap recognizer to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(bgImageView)
        //view.addSubview(appNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginBtn)
        //view.addSubview(registerBtn)
        
        /*appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
         appNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         appNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
         appNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true*/
        
        nameTextFieldTopAnchor = nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 350)
        nameTextFieldTopAnchor?.isActive = true
        
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        pwTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5).isActive = true
        pwTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pwTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        loginBtnBottomAnchor = loginBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        loginBtnBottomAnchor?.isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        
        
        /*registerBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 20).isActive = true
         registerBtn.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor).isActive = true
         registerBtn.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
         registerBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true*/
        
        bgImageViewTopAnchor = bgImageView.topAnchor.constraint(equalTo: view.topAnchor)
        bgImageViewTopAnchor?.isActive = true
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
    
    //login function
    func handleLogin() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        print(nameTextField.text!)
        print(pwTextField.text!)
        Client.login(params: params as [String : AnyObject]) { (isFinished) in
            if (isFinished) {
                self.present(self.getToTabBarController(), animated: true, completion: nil)
            }
        }
    }
    
    func keyboardDidShow(notification : NSNotification) {
        print("Keyboard did show")
        let keyBoardHeight = getInfoOfKeyBoard(notification: notification)["height"] as? CGFloat
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as? Float
        let resizingDistance = -(keyBoardHeight!) - 10
        self.nameTextFieldTopAnchor?.isActive = false
        self.nameTextFieldTopAnchor = self.nameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 340 + resizingDistance)
        self.nameTextFieldTopAnchor?.isActive = true
        
        self.loginBtnBottomAnchor?.isActive = false
        self.loginBtnBottomAnchor = self.loginBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: resizingDistance)
        self.loginBtnBottomAnchor?.isActive = true
        
        self.bgImageViewTopAnchor?.isActive = false
        self.bgImageViewTopAnchor = self.bgImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: resizingDistance + 10)
        self.bgImageViewTopAnchor?.isActive = true
        
        UIView.animate(withDuration: TimeInterval(keyBoardDuration!)) {
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    func keyboardDidHide(notification : NSNotification) {
        print("Keyboard did Hide")
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as? Float
        
        
        self.nameTextFieldTopAnchor?.isActive = false
        self.nameTextFieldTopAnchor = self.nameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 350)
        self.nameTextFieldTopAnchor?.isActive = true
        
        self.loginBtnBottomAnchor?.isActive = false
        self.loginBtnBottomAnchor = self.loginBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10)
        self.loginBtnBottomAnchor?.isActive = true
        self.bgImageViewTopAnchor?.isActive = false
        self.bgImageViewTopAnchor = self.bgImageView.topAnchor.constraint(equalTo: self.view.topAnchor)
        self.bgImageViewTopAnchor?.isActive = true
        
        UIView.animate(withDuration: TimeInterval(keyBoardDuration!)) {
            self.view.layoutIfNeeded()
            
        }
    }
    
    func getInfoOfKeyBoard(notification : NSNotification) -> [String : Any] {
        let userInfo = notification.userInfo! as Dictionary
        let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let keyboardDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        var keyboardInfo = [String : Any]()
        keyboardInfo["height"] = keyboardHeight
        keyboardInfo["duration"] = keyboardDuration
        return keyboardInfo
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
    func handleRegister() {
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

