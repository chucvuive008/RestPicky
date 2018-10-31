//
//  ProfileViewController.swift
//  RestPicky
//
//  Created by user145117 on 10/27/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

//Delegate and datasource needed for tableview
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Our list for the tableview
    let list = ["Reviews", "Photos", "Bookmarks", "Recents"]
    
    //Elements on the page
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    //Firebase database reference
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Firebase database reference
        ref = Database.database().reference()
        
        //TableView data
        tableView.delegate = self
        tableView.dataSource = self
        
        //Retreive user "name" from database
        let userID = Auth.auth().currentUser?.uid
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            print(username)
            //Set usernameLabel
            self.usernameLabel.text = username
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
            // Do any additional setup after loading the view.
    }
    
    //New Photo Button
    @IBAction func newPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            print("present")
        }
        print("pressed")
    }
    
    //Image Controller
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            print("success")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    //Table Actions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(list[indexPath.row].lowercased())
        performSegue(withIdentifier: list[indexPath.row].lowercased() + "Segue", sender: self)
    }
    
    
    
}
