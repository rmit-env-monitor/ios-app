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
import PKHUD

class myTextField : YoshikoTextField {
    override func becomeFirstResponder() -> Bool {
        if (!self.canBecomeFirstResponder) {
            return false
        }
        UIView.animate(withDuration: 0.2) {
            super.becomeFirstResponder()
        }
        return true
    }
}

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
    
    lazy var nameTextField : myTextField = {
        let tf = myTextField()
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
    
    lazy var pwTextField : myTextField = {
        let tf = myTextField()
        tf.font = UIFont.openSansLightFontOfSize(20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .white
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.placeholder = "PASSWORD"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.placeholderColor = .black
        return tf
    }()
    
    lazy var confirmTextField : myTextField = {
        let tf = myTextField()
        tf.font = UIFont.openSansLightFontOfSize(20)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.activeBackgroundColor = .white
        tf.activeBorderColor = .black
        tf.inactiveBorderColor = .gray
        tf.tintColor = .black
        tf.isSecureTextEntry = true
        tf.placeholder = "CONFIRM PASSWORD"
        tf.autocapitalizationType = .none
        tf.placeholderColor = .black
        return tf
    }()
    
    lazy var loginBtn : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.openSansLightFontOfSize(16)
        btn.setTitle("Login", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(r: 255, g: 102, b: 102)
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(handleLoginOrRegister), for: .touchUpInside)
        return btn
    }()
    
    lazy var registerLabel : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        _ = OpenSans.registerFonts()
        lb.font = UIFont.openSansFontOfSize(15)
        lb.text = "Don't have an account?"
        lb.textAlignment = .center
        lb.isUserInteractionEnabled = true
        let tapOnLabel = UITapGestureRecognizer()
        tapOnLabel.addTarget(self, action: #selector(handleOpenRegisterView))
        lb.addGestureRecognizer(tapOnLabel)
        return lb
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
    
    var nameTextFieldBottomAnchor : NSLayoutConstraint?
    var bgImageViewTopAnchor : NSLayoutConstraint?
    var registerLabelBottomAnchor : NSLayoutConstraint?
    //var loginBtnBottomAnchor : NSLayoutConstraint?
    
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
    
    func handleBackToLoginVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleOpenRegisterView(sender : UILabel) {
        if !isRegisterView {
            let loginController = LoginController()
            loginController.isRegisterView = true
            presentAnimation(vc: loginController)
        }
        else {
            dismissAnimation(vc: self)
        }
        
    }
    
    func presentAnimation(vc : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        
        present(vc, animated: false, completion: nil)
    }
    
    func dismissAnimation(vc : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionReveal
        view.window!.layer.add(transition, forKey: kCATransition)
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
    var isRegisterView : Bool = false {
        didSet {
            updateLoginOrRegisterUI()
        }
    }
    
    func updateLoginOrRegisterUI() {
        if isRegisterView {
            loginBtn.setTitle("Register", for: .normal)
            registerLabel.text = "I have an account already"
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
        }
    }
    
    func handleLoginOrRegister() {
        if isRegisterView {
            handleRegister()
        }
        else {
            handleLogin()
        }
    }
    
    let distanceFromRegisterLabelToBottomView : CGFloat = -5
    
    func setupUI() {
        _ = OpenSans.registerFonts()
        //hint: add observer when keyboard appears to handle UI resizing
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //hint: add tap recognizer to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        view.addSubview(bgImageView)
        //view.addSubview(appNameLabel)
        view.addSubview(nameTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginBtn)
        view.addSubview(registerLabel)
        //view.addSubview(registerBtn)
        
        /*appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
         appNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         appNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
         appNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true*/
        
        registerLabelBottomAnchor = registerLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distanceFromRegisterLabelToBottomView)
        registerLabelBottomAnchor?.isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        registerLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        registerLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        
        loginBtn.bottomAnchor.constraint(equalTo: registerLabel.topAnchor, constant: -10)
            .isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: registerLabel.leadingAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        
        if isRegisterView {
            view.addSubview(confirmTextField)
            confirmTextField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -10).isActive = true
            confirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            confirmTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
            confirmTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        pwTextField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -80).isActive = true
        pwTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pwTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameTextFieldBottomAnchor = nameTextField.bottomAnchor.constraint(equalTo: pwTextField.topAnchor, constant: -10)
        nameTextFieldBottomAnchor?.isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        
        
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
    
    func keyboardWillShow(notification : NSNotification) {
        print("Keyboard did show")
        let keyBoardHeight = getInfoOfKeyBoard(notification: notification)["height"] as? CGFloat
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as! Float
        
        let resizingDistance = -(keyBoardHeight!) - 10
        //        self.nameTextFieldBottomAnchor?.isActive = false
        //        self.nameTextFieldBottomAnchor = self.nameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 340 + resizingDistance)
        //        self.nameTextFieldBottomAnchor?.isActive = true
        
        self.registerLabelBottomAnchor?.isActive = false
        self.registerLabelBottomAnchor = self.registerLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: resizingDistance + distanceFromRegisterLabelToBottomView)
        self.registerLabelBottomAnchor?.isActive = true
        
        self.bgImageViewTopAnchor?.isActive = false
        self.bgImageViewTopAnchor = self.bgImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: resizingDistance + 10)
        self.bgImageViewTopAnchor?.isActive = true
        
        UIView.animate(withDuration: TimeInterval(keyBoardDuration)) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification : NSNotification) {
        print("Keyboard did Hide")
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as? Float
        
        
        self.registerLabelBottomAnchor?.isActive = false
        self.registerLabelBottomAnchor = self.registerLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: distanceFromRegisterLabelToBottomView)
        self.registerLabelBottomAnchor?.isActive = true
        
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
        HUD.show(.progress)
        Client.register(params: params as [String : AnyObject]) { (isFinished) in
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            HUD.hide({ (finished) in
                if (self.pwTextField.text! != self.confirmTextField.text!) {
                    alertController.title = "Confirmed password does not matched, please try again:D"
                    
                }
                else if (isFinished) {
                    alertController.title = "You have registered successfully"
                    self.dismissAnimation(vc: self)
                }
                else {
                    alertController.title = "An unknown error occurs or username has been taken:("
                    
                }
                self.present(alertController, animated: true, completion: nil)
                
            })
        }
    }
    
    //login function
    func handleLogin() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        print(nameTextField.text!)
        print(pwTextField.text!)
        HUD.show(.progress)
        HUD.dimsBackground = true
        Client.login(params: params as [String : AnyObject]) { (isFinished) in
            let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            
            if (isFinished) {
                HUD.hide({ (finished) in
                    self.present(self.getToTabBarController(), animated: true, completion: nil)
                })
                
            }
            else {
                HUD.hide({ (finished) in
                    alertController.title = "Invalid username/password. Please try again:D"
                })
                
            }
        }
    }
}

