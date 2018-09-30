//
//  RegisterViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    emailTextField.layer.cornerRadius = 15
    passwordTextField.layer.cornerRadius = 15
    emailTextField.layer.masksToBounds = true
    passwordTextField.layer.masksToBounds = true
    signUpButton.layer.cornerRadius = 15
    emailTextField.layer.borderWidth = 0
    passwordTextField.layer.borderWidth = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonPress(_ sender: Any) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error)
                SVProgressHUD.dismiss()
            } else {
                print("register Successful!")
                SVProgressHUD.dismiss()
                self.performSegue(withIdentifier: "RegisterToSearch", sender: self)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
