//
//  LoginViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameTextField.layer.borderWidth = 0
        self.passwordTextField.layer.borderWidth = 0
        self.usernameTextField.layer.cornerRadius = 16
        self.passwordTextField.layer.cornerRadius = 16
        self.usernameTextField.layer.masksToBounds = true
        self.passwordTextField.layer.masksToBounds = true
        
        self.signInButton.layer.cornerRadius = 16
        self.signUpButton.layer.cornerRadius = 16
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonPress(_ sender: Any) {
        performSegue(withIdentifier: "LoginToRegister", sender: self)
    }
    
    @IBAction func SignInButtonPress(_ sender: Any) {
        SVProgressHUD.show()
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!)
        { (user, error) in
            if error != nil {
                print (error!)
            } else {
                print("Log in successful")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "LoginToSearch", sender: self)
            }
            
        }
    }
}
