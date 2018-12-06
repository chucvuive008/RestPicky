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
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, updateUserDelegate {
    
    func updateUser(_user: User) {
        usernameLabel.text = _user.name
        emailLabel.text = _user.email
        phoneLabel.text = _user.phone
        addressLabel.text = _user.address
    }
    
    let list = ["Reviews", "Edit"]
    
    //Elements on the page
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var restaurants = [Restaurant]()
    var reviewsInt = [Int]()
    //Firebase database reference
    var ref: DatabaseReference!
    var userID: String = ""
    var yourReviewsRestaurants = [Restaurant]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewsSegue" {
            let userID = Auth.auth().currentUser?.uid
            for restaurant in restaurants {
                for review in restaurant.review {
                    if review.userId == userID {
                        yourReviewsRestaurants.append(restaurant)
                        reviewsInt.append(review.id)
                        print("Found your comment")
                    }
                }
            }
            
            let seg = segue.destination as! ReviewsViewController
            print(seg.reviewsInt)
            print(seg.restaurants)
//            if seg.reviewsInt.count == reviewsInt.count {
//                seg.restaurants = []
//                seg.reviewsInt = []
//                print("nothing")
//            } else {
                seg.reviewsInt = reviewsInt
                seg.restaurants = yourReviewsRestaurants
//            }
            yourReviewsRestaurants = []
            reviewsInt = []
        }
        
        if segue.identifier == "editSegue" {
            let seg = segue.destination as! EditViewController
            seg.updateUserDelegate = self
        }
    }
    
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
        
        //Load Profile Image
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        let userID = Auth.auth().currentUser?.uid
        let starsRef = Storage.storage().reference().child("image.jpg")
        let prf = "profileImage"
        self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/user%2F\(userID!)%2F\(prf).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", profImg: profileImage)
    
        //TableView data
        tableView.delegate = self
        tableView.dataSource = self
        
        //Retreive user "name" from database
        ref = Database.database().reference()
        ref.child("user").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            let address = value?["address"] as? String ?? ""
            print(username)
            print(email)
            print(phone)
            print(type(of: phone))
            //Set usernameLabel
            self.usernameLabel.text = username
            // ...
            
            //Set emailLabel
            self.emailLabel.text = "Email: \(email)"
            //...
            self.addressLabel.text = "Address: \(address)"
            //Set phoneLabel
            self.phoneLabel.text = "Phone: \(phone)"
            //...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getPhoto (urlString : String, profImg: UIImageView){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if data != nil{
                    profImg.image = UIImage(data: data!)!
                }
            }
        }).resume()
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
//        let databaseRef = ref.child("user/").child(userID).child("profilePics/")
        let storageRef = Storage.storage().reference().child("user/").child(userID).child("profileImage.jpg/")
        var uploadData = image.jpegData(compressionQuality: 0.6)
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
