//
//  SearchViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 11/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var restaurantList = [Restaurant]()
    var currentRestaurantList = [Restaurant]()
    var selectedRestaurant = Restaurant()

    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        currentRestaurantList = restaurantList
        searchBar.backgroundImage = UIImage()
        searchBar.layer.borderWidth = 0
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        searchBar.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector("endEditing:")))
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentRestaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let name = cell.viewWithTag(100) as! UILabel
        let address = cell.viewWithTag(101) as! UILabel
        let phone = cell.viewWithTag(102) as! UILabel
        let image = cell.viewWithTag(103) as! UIImageView
        let starImage1 = cell.viewWithTag(50) as! UIImageView
        let starImage2 = cell.viewWithTag(51) as! UIImageView
        let starImage3 = cell.viewWithTag(52) as! UIImageView
        let starImage4 = cell.viewWithTag(53) as! UIImageView
        let starImage5 = cell.viewWithTag(54) as! UIImageView
        
        setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, restaurant: currentRestaurantList[indexPath.row])
        
        name.text = currentRestaurantList[indexPath.row].name
        address.text = currentRestaurantList[indexPath.row].street + ", " + currentRestaurantList[indexPath.row].city + ", " + currentRestaurantList[indexPath.row].state + ", \(currentRestaurantList[indexPath.row].zipcode)"
        phone.text = currentRestaurantList[indexPath.row].phoneNumber
        image.image = currentRestaurantList[indexPath.row].images[0]
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRestaurant = restaurantList[indexPath.row]
        performSegue(withIdentifier: "restaurantdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantdetail"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = selectedRestaurant
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentRestaurantList = restaurantList
            restaurantsTableView.reloadData()
            return
        }
        currentRestaurantList = restaurantList.filter({ (restaurant) -> Bool in
            restaurant.name.lowercased().contains(searchText.lowercased())  ||
            restaurant.city.lowercased().contains(searchText.lowercased())  ||
            restaurant.street.lowercased().contains(searchText.lowercased()) ||
            restaurant.type.lowercased().contains(searchText.lowercased())
        })
        restaurantsTableView.reloadData()
    
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
