//
//  ViewController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController {
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let dictionary = Client.userDefaults.dictionary(forKey: "CurrentUser") {
            Client.currentUser = User(dictionary: dictionary as [String : AnyObject])
            
            self.performSegue(withIdentifier: "LoginSuccessfully", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onLogin(_ sender: UIButton) {
        let params : [String : String] = ["username" : usernameTextField.text! , "password" : passwordTextField.text!]
        Client.login(params: params as [String : AnyObject]) { (isFinished) in
            if (isFinished) {
                self.performSegue(withIdentifier: "LoginSuccessfully", sender: nil)
            }
        }
    }
    
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSuccessfully" {
            print("Move to DashBoardView")
        }
     }

    @IBAction func onRegister(_ sender: UIButton) {
        let params : [String : String] = ["username" : usernameTextField.text! , "password" : passwordTextField.text!]
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

