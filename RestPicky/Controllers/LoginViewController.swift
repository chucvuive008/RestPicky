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
                if error!.localizedDescription == "Network error (such as timeout, interrupted connection or unreachable host) has occurred." {
                    self.alert(title: "" , message: "Network Error")
                } else if error!.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."{
                    self.alert(title: "", message: "User does not exist")
                } else {
                    self.alert(title: "", message: "\(error!.localizedDescription)")
                }
                SVProgressHUD.dismiss()
            } else {
                
                SVProgressHUD.dismiss()
                
                if (Auth.auth().currentUser?.isEmailVerified)! {
                    print("Log in successful")
                    self.performSegue(withIdentifier: "LoginToSearch", sender: self)
                }
                else {
                    self.alert(title: "", message: "Please verify your email")
                }
//
            }
            
        }
    }
    
    func alert (title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
