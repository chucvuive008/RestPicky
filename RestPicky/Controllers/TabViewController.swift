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
        
        getBookmarkRestaurants()
        
//        self.ref?.child("user/\(user.uid)/bookmark/\((user.bookmarks.last?.id)! + 1)").setValue(["id":(user.bookmarks.last?.id)! + 1, "restaurantId": 15])
        
        for viewController in viewControllers!{
            if let bookmarkViewController = viewController as? BookmarkViewController
            {
                bookmarkViewController.restaurants = self.bookmarkRestaurants
                bookmarkViewController.currentUser = self.user
                bookmarkViewController.allRestaurants = self.newRestaurants
            }else if let searchViewController = viewController as? SearchViewController{
                searchViewController.restaurantList = self.newRestaurants
                searchViewController.user = self.user
            }else if let homeViewController = viewController as? HomeViewController {
                homeViewController.newRestaurants = self.newRestaurants
                homeViewController.user = self.user
            }else if let navigationController = viewController as? UINavigationController {
                var profileViewController = navigationController.viewControllers.first as? ProfileViewController
                profileViewController?.restaurants = self.newRestaurants
            }
        }
    }
    
    func getBookmarkRestaurants(){
        for restaurant in newRestaurants{
            if user.restaurantsIdBookmark.contains(restaurant.id){
                bookmarkRestaurants.append(restaurant)
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        for viewController in viewControllers!{
//            if let homeViewController = viewController as? HomeViewController {
//                homeViewController.CollectionTableView.reloadData()
//            }
//        }
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
