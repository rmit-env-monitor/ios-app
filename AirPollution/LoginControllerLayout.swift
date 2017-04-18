//
//  LoginControllerLayout.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/16/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import OpenSansSwift
import PKHUD
import PopupDialog

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

