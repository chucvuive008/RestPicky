//
//  BookmarkViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 12/3/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

class BookmarkViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var ref : DatabaseReference?
    var restaurants = [Restaurant]()
    var allRestaurants = [Restaurant]()
    var selectedRestaurant = Restaurant()
    var currentUser = User()
    @IBOutlet weak var restaurantTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        var user = User()
        user.uid = currentUser.uid
        self.ref?.child("user/\(user.uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            if let result = snapshot.value as? NSDictionary {
                for child in result{
                    if child.key as! String == "bookmark"{
                        if let childSnapshot = snapshot.childSnapshot(forPath: "bookmark/").value as? NSArray{
                            for i in 1..<childSnapshot.count{
                                let bookmark = Bookmark()
                                if let dic = childSnapshot[i] as? NSDictionary{
                                    for property in dic{
                                        if property.key as! String == "restaurantId"{
                                            bookmark.restaurantId = property.value as! Int
                                        }
                                        if property.key as! String == "id"{
                                            bookmark.id = property.value as! Int
                                        }
                                        if property.key as! String == "mark"{
                                            bookmark.mark = property.value as! Bool
                                        }
                                    }
                                }
                                if bookmark.id != 0 && bookmark.restaurantId != 0{
                                    user.bookmarks.append(bookmark)
                                }
                            }
                            if user.bookmarks != nil{
                                for bookmark in user.bookmarks{
                                    if bookmark.mark{
                                        user.restaurantsIdBookmark.append(bookmark.restaurantId)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            self.restaurants =  self.getBookmarkRestaurants(user: user)
            self.restaurantTableView.reloadData()
        })
    }
    
    func getBookmarkRestaurants(user: User) -> [Restaurant]{
        var bookmarkRestaurants = [Restaurant]()
        for restaurant in allRestaurants{
            if user.restaurantsIdBookmark.contains(restaurant.id){
                bookmarkRestaurants.append(restaurant)
            }
        }
        return bookmarkRestaurants
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let nameLabel = cell.viewWithTag(1) as! UILabel
        let addressLabel = cell.viewWithTag(2) as! UILabel
        let phoneLabel = cell.viewWithTag(3) as! UILabel
        let restaurantImageView = cell.viewWithTag(4) as! UIImageView
        let starImage1 = cell.viewWithTag(50) as! UIImageView
        let starImage2 = cell.viewWithTag(51) as! UIImageView
        let starImage3 = cell.viewWithTag(52) as! UIImageView
        let starImage4 = cell.viewWithTag(53) as! UIImageView
        let starImage5 = cell.viewWithTag(54) as! UIImageView
        
        setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, restaurant: restaurants[indexPath.row])
        
        nameLabel.text = restaurants[indexPath.row].name
        addressLabel.text = restaurants[indexPath.row].street + ", " + restaurants[indexPath.row].city + ", " + restaurants[indexPath.row].state + ", \(restaurants[indexPath.row].zipcode)"
        phoneLabel.text = restaurants[indexPath.row].phoneNumber
        
        restaurantImageView.image = restaurants[indexPath.row].images[0]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        // Configure the cell...
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantdetail"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = selectedRestaurant
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = restaurants[indexPath.row]
        performSegue(withIdentifier: "restaurantdetail", sender: self)
    }
    
    func setRatingImagesByRestaurantRating(image1: UIImageView, image2: UIImageView, image3: UIImageView, image4: UIImageView, image5: UIImageView, restaurant: Restaurant){
        var totalRating : Double = 0
        for review in restaurant.review{
            totalRating += review.rating
        }
        var averageRating = 0.0
        
        if restaurant.review.count != 0{
            averageRating = totalRating/Double(restaurant.review.count)
        }
        
        if averageRating < 0.5{
            image1.image = UIImage(named: "BlankStarIcon")
            image2.image = UIImage(named: "BlankStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if averageRating >= 0.5 && averageRating < 1.5{
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "BlankStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if averageRating >= 1.5 && averageRating < 2.5 {
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if averageRating >= 2.5 && averageRating < 3.5{
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "YellowStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if averageRating >= 3.5 && averageRating < 4.5 {
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "YellowStarIcon")
            image4.image = UIImage(named: "YellowStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else {
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "YellowStarIcon")
            image4.image = UIImage(named: "YellowStarIcon")
            image5.image = UIImage(named: "YellowStarIcon")
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
