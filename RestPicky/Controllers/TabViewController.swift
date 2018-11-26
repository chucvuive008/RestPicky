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
    var bookmarkRestaurants = [Restaurant]()
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
        
        for viewController in self.viewControllers!{
            if let searchViewController = viewController as? HomeViewController {
                searchViewController.newRestaurants = self.newRestaurants
            }
        }
        
        ref?.child("user/\(user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.value as? NSDictionary {
                for child in result{
                    if child.key as! String == "bookmark"{
                        if let childSnapshot = snapshot.childSnapshot(forPath: "bookmark/").value as? NSArray{
                            for i in 1..<childSnapshot.count{
                                if let dic = childSnapshot[i] as? NSDictionary{
                                    for property in dic{
                                        if property.key as! String == "restaurantId"{
                                            self.user.restaurantsIdBookmark.append(property.value as! Int)
                                        }
                                    }
                                }
                            }
                            getBookmarkRestaurants()
                            for viewController in self.viewControllers!{
                                if let bookmarkViewController = viewController as? BookmarkTableViewController
                                {
                                    bookmarkViewController.restaurants = self.bookmarkRestaurants
                                }
                            }

                        }
                    }
                }
            }
        })
        
        guard let viewControllers = viewControllers else {
            return
        }
    

        
        func getBookmarkRestaurants(){
            for restaurant in newRestaurants{
                if user.restaurantsIdBookmark.contains(restaurant.id){
                    bookmarkRestaurants.append(restaurant)
                }

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
