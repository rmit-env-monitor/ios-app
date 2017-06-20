//
//  LoginControllerLayout.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/16/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import PKHUD
import PopupDialog

//MARK : setup view constraints
extension LoginController {
    func setupUI() {
        
        view.backgroundColor = UIColor.white
        
        //add observer when keyboard appears to handle UI resizing
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
        view.addSubview(nameTextField)
        view.addSubview(pwTextField)
        view.addSubview(loginBtn)
        view.addSubview(signUpLabel)
        
        registerLabelBottomAnchor = signUpLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: distanceFromRegisterLabelToBottomView)
        registerLabelBottomAnchor?.isActive = true
        signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        signUpLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 100).isActive = true
        
        loginBtn.bottomAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: -10)
            .isActive = true
        loginBtn.leadingAnchor.constraint(equalTo: pwTextField.leadingAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: view.bounds.width - 150).isActive = true
        
        if isRegisterView {
            view.addSubview(confirmTextField)
            confirmTextField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -10).isActive = true
            confirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            confirmTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 140).isActive = true
            confirmTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        
        pwTextField.bottomAnchor.constraint(equalTo: loginBtn.topAnchor, constant: -15).isActive = true
        pwTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pwTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 150).isActive = true
        pwTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameTextFieldBottomAnchor = nameTextField.bottomAnchor.constraint(equalTo: pwTextField.topAnchor, constant: -10)
        nameTextFieldBottomAnchor?.isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 150).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}

