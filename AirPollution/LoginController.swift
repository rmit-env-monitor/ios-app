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
import PopupDialog
import MapKit

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

    var esTabBarController : ESTabBarController?
  
    
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
    
    lazy var bgImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loginbg")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var smartDashBoardVC : SmartDashBoardController?
    var fullDashBoardVC : FullDashBoardController?
    
    var alertController : UIAlertController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Client.userDefaults.removeObject(forKey: currentUserKey)
        if let dictionary = Client.userDefaults.dictionary(forKey: currentUserKey) {
            Client.currentUser = User(dictionary: dictionary as [String : AnyObject])
            self.present(getToTabBarController(), animated: true, completion: nil)
        }


    }
    
    
    var nameTextFieldBottomAnchor : NSLayoutConstraint?
    var bgImageViewTopAnchor : NSLayoutConstraint?
    var registerLabelBottomAnchor : NSLayoutConstraint?
    
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
    
    func handleOpenRegisterView(_ sender : UILabel) {
        if !isRegisterView {
            let loginController = LoginController()
            loginController.isRegisterView = true
            presentAnimation(loginController)
        }
        else {
            dismissAnimation(self)
        }
        
    }
    
    func presentAnimation(_ vc : UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        present(vc, animated: false, completion: nil)
    }
    
    func dismissAnimation(_ vc : UIViewController) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification : NSNotification) {
        let keyBoardHeight = getInfoOfKeyBoard(notification: notification)["height"] as? CGFloat
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as! Float
        
        let resizingDistance = -(keyBoardHeight!) - 10
        
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
        let v3 = UIViewController()
        let v4 = UIViewController()
        
        smartDashBoardVC = storyboard?.instantiateViewController(withIdentifier: "SmartDashBoardController") as? SmartDashBoardController
        
        fullDashBoardVC = storyboard?.instantiateViewController(withIdentifier: "FullDashBoardController") as? FullDashBoardController
        esTabBarController = ESTabBarController()
        
        if let tabBar = esTabBarController?.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
            tabBar.backgroundColor = UIColor.black
        }
        let smartDashBoardNC = UINavigationController(rootViewController: smartDashBoardVC!)
        
        let fullDashBoardNC = UINavigationController(rootViewController: fullDashBoardVC!)
        
        smartDashBoardNC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"), tag: 1)
        fullDashBoardNC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "All Sensors", image: UIImage(named: "currentlocation"), selectedImage: UIImage(named: "currentlocation"), tag: 2)
        v3.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Routing", image: UIImage(named: "routing"), selectedImage: UIImage(named: "routing"), tag: 3)
        v4.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"), tag: 4)
        
        esTabBarController?.viewControllers = [smartDashBoardNC,fullDashBoardNC,v3,v4]
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarControllerWhenLoggedOut), name: Notification.Name("handleTabBarControllerWhenLoggedOut"), object: nil)
        return esTabBarController!
    }
    
    func handleTabBarControllerWhenLoggedOut() {
        self.esTabBarController = nil
    }
    
    //Register event
    func handleRegister() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        HUD.show(.progress)
        HUD.allowsInteraction = false
        Client.register(params as [String : AnyObject]) { (isFinished) in
            HUD.hide({ (finished) in
                if (self.pwTextField.text! != self.confirmTextField.text!) {
                    self.alertController?.title = "Confirmed password does not matched, please try again:D"
                    
                }
                else if (isFinished) {
                    self.alertController?.title = "You have registered successfully"
                    self.dismissAnimation(self)
                }
                else {
                    self.alertController?.title = "An unknown error occurs or username has been taken:("
                    
                }
                self.present(self.alertController!, animated: true, completion: nil)
            })
        }
    }
    
    //open PopupView to ask user about the location
    lazy var popUpView : UIView =  {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    var popUp : PopupDialog!
    func openPopUpView() {
        let popUpVC = storyboard?.instantiateViewController(withIdentifier: "LoginPopUpVC") as! PopUpViewController
        popUpVC.delegate = self
        popUp = PopupDialog(viewController: popUpVC)
        present(popUp, animated: true, completion: nil)
    }
    

    //login function
    func handleLogin() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        self.view.isUserInteractionEnabled = false
        
        HUD.show(.progress)
        HUD.dimsBackground = true
        Client.login(params as [String : AnyObject]) { (isFinished) in
        
            if (isFinished) {
                HUD.hide({ (finished) in
                    self.openPopUpView()
                })
            }
            else {
                HUD.hide({ (finished) in
                    self.alertController?.title = "Invalid username/password. Please try again:D"
                    self.present(self.alertController!, animated: true, completion: nil)
                })
                
            }
            self.view.isUserInteractionEnabled = true

        }

    }

}


//MARK : handle getting location of user
extension LoginController : PopUpViewControllerDelegate {
    func getCurrentLocation(method: locationMethod) {
        popUp.dismiss(animated: true, completion: { 
            switch method {
            case .manually:
                Client.userDefaults.set("\(locationMethod.manually)", forKey: locationMethodKey)
                self.present(self.getToTabBarController(), animated: true, completion: nil)
                break
            case .automatically:
                Client.userDefaults.set("\(locationMethod.automatically)", forKey: locationMethodKey)
                self.present(self.getToTabBarController(), animated: true, completion: nil)
                break
            case .none:
                Client.userDefaults.removeObject(forKey: currentUserKey)
                break
            }
        })
    }
}



//MARK : setup view constraints
extension LoginController {
    func setupUI() {
        _ = OpenSans.registerFonts()
        //hint: add observer when keyboard appears to handle UI resizing
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //set up alert view
        alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (result) in
            self.alertController?.dismiss(animated: true, completion: nil)
        })
        alertController?.addAction(okAction)
        
        //hint: add tap recognizer to dismiss keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.addSubview(bgImageView)
        view.addSubview(nameTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginBtn)
        view.addSubview(registerLabel)
        
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
        
        bgImageViewTopAnchor = bgImageView.topAnchor.constraint(equalTo: view.topAnchor)
        bgImageViewTopAnchor?.isActive = true
        bgImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        bgImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }

}

