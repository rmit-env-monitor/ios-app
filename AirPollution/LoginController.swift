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
import PKHUD
import PopupDialog
import MapKit

class LoginController: UIViewController {
    lazy var nameTextField : UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    lazy var pwTextField : UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    lazy var confirmTextField : UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    lazy var loginButton : UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.getFutura(fontSize: 16)
        btn.setTitle("Login", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(r: 0, g: 204, b: 153)
        btn.layer.masksToBounds = true
        btn.isUserInteractionEnabled = true
        btn.addTarget(self, action: #selector(handleLoginOrRegister), for: .touchUpInside)
        return btn
    }()
    
    lazy var signUpButton : UIButton = {
        let lb = UIButton()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.titleLabel?.text = "Sign Up"
        lb.titleLabel?.font = UIFont.getFutura(fontSize: 15)
        lb.titleLabel?.textAlignment = .center
        lb.titleLabel?.backgroundColor = .blue
        lb.titleLabel?.textColor = .black
        lb.isUserInteractionEnabled = true
        let tapOnLabel = UITapGestureRecognizer()
        tapOnLabel.addTarget(self, action: #selector(handleOpenRegisterView))
        lb.addGestureRecognizer(tapOnLabel)
        return lb
    }()
    
    var alertController : UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupUI()
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
            loginButton.setTitle("Register", for: .normal)
            signUpButton.titleLabel?.text = "I have an account already"
        }
        else {
            loginButton.setTitle("Login", for: .normal)
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
    
    let distanceFromRegisterLabelToBottomView : CGFloat = -130
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification : NSNotification) {
        let keyBoardHeight = getInfoOfKeyBoard(notification: notification)["height"] as? CGFloat
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as! Float
        
        let resizingDistance = -(keyBoardHeight!) - 10
        
        self.registerLabelBottomAnchor?.isActive = false
        self.registerLabelBottomAnchor = self.signUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: resizingDistance + distanceFromRegisterLabelToBottomView)
        self.registerLabelBottomAnchor?.isActive = true
        
        
        
        UIView.animate(withDuration: TimeInterval(keyBoardDuration)) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification : NSNotification) {
        let keyBoardDuration = getInfoOfKeyBoard(notification: notification)["duration"] as? Float
        
        self.registerLabelBottomAnchor?.isActive = false
        self.registerLabelBottomAnchor = self.signUpButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: distanceFromRegisterLabelToBottomView)
        self.registerLabelBottomAnchor?.isActive = true
        
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
    
    //Register event
    func handleRegister() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        self.dismissKeyboard()
        self.view.isUserInteractionEnabled = false
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
    
    //Open PopupView to ask user about the location
    lazy var popUpView : UIView =  {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var popUp : PopupDialog!
    func openPopUpView() {
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: "LoginPopUpVC") as! PopUpViewController
        popUpVC.delegate = self
        popUp = PopupDialog(viewController: popUpVC)
        present(popUp, animated: true, completion: nil)
    }
    
    //Login function
    func handleLogin() {
        let params : [String : String] = ["username" : nameTextField.text! , "password" : pwTextField.text!]
        self.dismissKeyboard()
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

// MARK : handle getting location of user
extension LoginController : PopUpViewControllerDelegate {
    func getCurrentLocation(method: locationMethod) {
        popUp.dismiss(animated: true, completion: {
            switch method {
            case .manually:
                userDefaults.set("\(locationMethod.manually)", forKey: locationMethodKey)
                self.present(EsTabBarController.sharedInstance.open(), animated: true, completion: nil)
                break
            case .automatically:
                userDefaults.set("\(locationMethod.automatically)", forKey: locationMethodKey)
                self.present(EsTabBarController.sharedInstance.open(), animated: true, completion: nil)
                break
            case .none:
                userDefaults.removeObject(forKey: currentUserKey)
                break
            }
        })
    }
}



