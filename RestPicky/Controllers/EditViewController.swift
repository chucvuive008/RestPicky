//
//  EditViewController.swift
//  RestPicky
//
//  Created by Team3 on 11/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

protocol updateUserDelegate{
    func updateUser(_user: User)
}

class EditViewController: UIViewController {
    var databaseRef : DatabaseReference!
    var userID: String = ""
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var updateUserDelegate : updateUserDelegate?
    var user = User()
    
    @IBAction func submitButton(_ sender: Any) {
        //If text field is not empty update database with values entered
        let alert = UIAlertController(title: "", message: "Do you want to submit the changes", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: { action in
            if(self.nameTextField.text != nil){
                self.postProfileInfo(type: "name", text: self.nameTextField.text!)
                self.user.name = self.nameTextField.text!
            }
            if(self.addressTextField.text != nil){
                self.postProfileInfo(type: "address", text: self.addressTextField.text!)
                self.user.address = self.addressTextField.text!
            }
            if(self.phoneTextField.text != nil){
                self.postProfileInfo(type: "phone", text: self.phoneTextField.text!)
                self.user.phone = self.phoneTextField.text!
            }
            self.updateUserDelegate?.updateUser(_user: self.user)
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func postProfileInfo(type:String, text:String) {
        let userId = Auth.auth().currentUser?.uid
        let childUpdates = [type: text]
        databaseRef.ref.child("user").child(userId!).updateChildValues(childUpdates)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = Auth.auth().currentUser?.uid
        databaseRef = Database.database().reference()
        databaseRef.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let address = value?["address"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            //Set usernameLabel
            self.nameTextField.text = username
            self.addressTextField.text = address
            self.phoneTextField.text = phone
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}
