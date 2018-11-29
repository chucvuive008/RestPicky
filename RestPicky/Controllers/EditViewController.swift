//
//  EditViewController.swift
//  RestPicky
//
//  Created by Team3 on 11/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase
class EditViewController: UIViewController {
    var databaseRef : DatabaseReference!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBAction func submitButton(_ sender: Any) {
        //If text field is not empty update database with values entered
        if(nameTextField.text != ""){postProfileInfo(type: "name", text: nameTextField.text!)}
        if(emailTextField.text != ""){postProfileInfo(type: "email", text: emailTextField.text!)}
        if(addressTextField.text != ""){postProfileInfo(type: "address", text: addressTextField.text!)}
        if(phoneTextField.text != ""){postProfileInfo(type: "phone", text: phoneTextField.text!)}
    }
    
    func postProfileInfo(type:String, text:String) {
        let userId = Auth.auth().currentUser?.uid
        let childUpdates = [type: text]
        databaseRef.ref.child("user").child(userId!).updateChildValues(childUpdates)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        databaseRef = Database.database().reference()
    }
}
