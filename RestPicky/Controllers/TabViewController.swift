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
    var finish = false
    var user = User()
    var currentUser : String?
    var ref : DatabaseReference?
    var newRestaurants = [Restaurant]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        user.uid = Auth.auth().currentUser?.uid ?? ""
        ref?.child("restaurant").observeSingleEvent(of: .value) { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                for child in result {
                    let orderID = child.key
                    print(orderID)
                }
            }
        }
        


        
        guard let viewControllers = viewControllers else {
            return
        }
    
        for viewController in viewControllers{
            if let searchViewController = viewController as? SearchViewController {
                searchViewController.newRestaurants = newRestaurants
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
