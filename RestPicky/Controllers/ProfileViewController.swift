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
    var userID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set Back Button properties
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        //Navigation Title properties
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let user = Auth.auth().currentUser
        if let user = user {
            // The user's ID, unique to the Firebase project.
            // Do NOT use this value to authenticate with your backend server,
            // if you have one. Use getTokenWithCompletion:completion: instead.
            self.userID = user.uid
        }
        //Image properties
//        profileImage.layer.borderWidth = 1.0
//        profileImage.layer.masksToBounds = false
//        profileImage.layer.borderColor = UIColor.white.cgColor
//        profileImage.layer.cornerRadius = 150 / 2
//        profileImage.clipsToBounds = true
//        
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
    var imagePicker: UIImagePickerController!
    
    //New Photo Button
    @IBAction func newPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func uploadMedia( image: UIImage) {
        let databaseRef = ref.child("user/").child(userID).child("profilePics/")
        let storageRef = Storage.storage().reference().child("user/").child(userID).child("profilePics/")
        
        var uploadData = image.pngData()
        let uploadTask = storageRef.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
                guard let metadata = metadata else {
                    return
                }
            })
        // Add a progress observer to an upload task
        let observer = uploadTask.observe(.progress) { snapshot in
            // A progress event occured
            print(snapshot)
        }
        }
    
    //Image Controller
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        profileImage.image = selectedImage
        //Upload to firebase
        uploadMedia(image: selectedImage)
        print("function upload media")
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
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
    
    
    @IBAction func signoutBtnPress(_ sender: Any) {
         self.view.window!.rootViewController?.dismiss(animated: true, completion: nil)
            try! Auth.auth().signOut()
    }
    
    
}
