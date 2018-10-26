//
//  TabViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

class TabViewController: UITabBarController {
    
    var user = User()
    var currentUser : String?
    var ref : DatabaseReference?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        user.uid = Auth.auth().currentUser?.uid ?? ""
        ref?.child("user").child(user.uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.user.name = value?["name"] as? String ?? ""
            self.user.email = value?["email"] as? String ?? ""
        }
        
        print(user.email)
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
