//
//  EditViewController.swift
//  RestPicky
//
//  Created by Team3 on 11/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase
protocol editDelegate {
    func addUserFunction(Name: String, Address: String, Phone: String)
}
class EditViewController: UIViewController {
    var databaseRef : DatabaseReference!
    var delegate: editDelegate?
    var userID: String = ""
    var uName: String?
    var uAddress: String?
    var uPhone: String?
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!

    @IBAction func submitButton(_ sender: Any) {
        //If text field is not empty update database with values entered
//        if(nameTextField.text != ""){postProfileInfo(type: "name", text: nameTextField.text!)}
//        if(addressTextField.text != ""){postProfileInfo(type: "address", text: addressTextField.text!)}
//        if(phoneTextField.text != ""){postProfileInfo(type: "phone", text: phoneTextField.text!)}
        let alert = UIAlertController(title: "Confirmation", message: "Do you want to confirm these changes?", preferredStyle: .alert)
       
        let alert1 = UIAlertAction(title: "Yes", style: .default, handler: { action in
//            If text field is not empty update database with values entered
            if(self.nameTextField.text != ""){self.postProfileInfo(type: "name", text: self.nameTextField.text!)}
            if(self.addressTextField.text != ""){self.postProfileInfo(type: "address", text: self.addressTextField.text!)}
            if(self.phoneTextField.text != ""){self.postProfileInfo(type: "phone", text: self.phoneTextField.text!)}
            self.performSegue(withIdentifier: "toProfile", sender: self)
            
        })
        alert.addAction(alert1)
        
        let alert2 = UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Cancelling")
            })
        alert.addAction(alert2)

        self.present(alert, animated: true, completion: nil)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfile" {
            let seguetoProf = segue.destination as! ProfileViewController
//            seguetoProf.username = uName!
//            seguetoProf.address = uAddress!
//            seguetoProf.phone = uPhone!
//            delegate?.addUserFunction(Name: uName!, Address: uAddress!, Phone: uPhone!)
        }
    }
}
