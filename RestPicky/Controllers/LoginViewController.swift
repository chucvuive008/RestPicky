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
    var img = UIImage()
    var newRestaurants = [Restaurant]()
    var ref : DatabaseReference?
    
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
        ref = Database.database().reference()
        getRestaurants(restaurantArray: newRestaurants)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToSearch" {
            let controller = segue.destination as! TabViewController
            controller.newRestaurants = newRestaurants
            
        }
    }
    
    func getPhoto (urlString : String, restaurant: Restaurant){
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if data != nil{
                    restaurant.images.append(UIImage(data: data!)!)
                }
            }
        }).resume()
    }
    
    func getRestaurants(restaurantArray: Array<Restaurant>){
        ref?.child("restaurant").queryLimited(toLast: 6).observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let orderID = child.key
                    self.newRestaurants.append(Restaurant(localId: Int(orderID)!))
                }
                self.getRestaurantDetail()
            }
        })
    }
    
    func getRestaurantDetail(){
        for i in 0..<newRestaurants.count{
            ref?.child("restaurant/\(newRestaurants[i].id)").observeSingleEvent(of: .value, with: { (snapshot) in
                if let result = snapshot.value as? NSDictionary {
                    for child in result {
                        if child.key as! String == "images"{
                            if let childSnapshot = snapshot.childSnapshot(forPath: "images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.newRestaurants[i].id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.newRestaurants[i])
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.newRestaurants[i].street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.newRestaurants[i].city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.newRestaurants[i].state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.newRestaurants[i].latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.newRestaurants[i].longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.newRestaurants[i].name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.newRestaurants[i].phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.newRestaurants[i].zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.newRestaurants[i].type = child.value as! String
                        }
                        
                    }
                }
            })
        }
    }
    
    func alert (title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}
