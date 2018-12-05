//
//  SearchViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref : DatabaseReference?
    var selectedType = ""
    var selectedRestaurant = Restaurant()
    
    var user = User()
    var newRestaurants = [Restaurant]()
    var mostReviewRestaurants = [Restaurant]()
    var topRestaurants = [Restaurant]()
    var randomRestaurants = [Restaurant]()
    var americanRestaurants = [Restaurant]()
    var italianRestaurants = [Restaurant]()
    var japaneseRestaurants = [Restaurant]()
    var seafoodRestaurants = [Restaurant]()
    var mexicoRestaurants = [Restaurant]()
    var indianRestaurants = [Restaurant]()
    var chineseRestaurants = [Restaurant]()
    var soupRestaurants = [Restaurant]()
    var steakRestaurants = [Restaurant]()
    var selectedRestaurantList = [Restaurant]()
    let restaurantCollectionsName = ["New Restaurants", "Top Restaurants", "Random Restaurants", "Most review"]
    @IBOutlet weak var CollectionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostReviewRestaurants = newRestaurants.sorted{
            $0.review.count > $1.review.count
        }
        
        CollectionTableView.delegate = self
        CollectionTableView.dataSource = self
        ref = Database.database().reference()
        americanRestaurants = getRestaurantByType(type: "American")
        italianRestaurants = getRestaurantByType(type: "Italian")
        japaneseRestaurants = getRestaurantByType(type: "Japanese")
        seafoodRestaurants = getRestaurantByType(type: "Seafood")
        mexicoRestaurants = getRestaurantByType(type: "Mexican")
        indianRestaurants = getRestaurantByType(type: "Indian")
        chineseRestaurants = getRestaurantByType(type: "Chinese")
        soupRestaurants = getRestaurantByType(type: "Soup")
        steakRestaurants = getRestaurantByType(type: "Steak")
        var selectedNums = [Int]()
        while selectedNums.count < 10{
            let randomNum = Int.random(in: 0..<newRestaurants.count)
            if !selectedNums.contains(randomNum){
                selectedNums.append(randomNum)
                randomRestaurants.append(newRestaurants[randomNum])
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantCollectionsName.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func getRestaurantByType(type: String) -> Array<Restaurant> {
        var restaurants = [Restaurant]()
        for restaurant in newRestaurants{
            if restaurant.type == type
            {
                restaurants.append(restaurant)
            }
        }
        return restaurants
    }
    
    @IBAction func SelectRestaurantType(_ sender: UIButton) {
        if sender.tag == 1{
            selectedType = "American"
            selectedRestaurantList = americanRestaurants
        } else if sender.tag == 2{
            selectedType = "Japanese"
            selectedRestaurantList = japaneseRestaurants
        } else if sender.tag == 3{
            selectedType = "Seafood"
            selectedRestaurantList = seafoodRestaurants
        }else if sender.tag == 4{
            selectedType = "Italian"
            selectedRestaurantList = italianRestaurants
        } else if sender.tag == 5{
            selectedType = "Mexican"
            selectedRestaurantList = mexicoRestaurants
        } else if sender.tag == 6{
            selectedType = "Indian"
            selectedRestaurantList = indianRestaurants
        } else if sender.tag == 7{
            selectedType = "Chinese"
            selectedRestaurantList = chineseRestaurants
        } else if sender.tag == 8{
            selectedType = "Soup"
            selectedRestaurantList = soupRestaurants
        } else if sender.tag == 9{
            selectedType = "Steak"
            selectedRestaurantList = steakRestaurants
        }
        performSegue(withIdentifier: "restaurantlist", sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collectionName = cell.viewWithTag(5) as! UILabel
        collectionName.text = restaurantCollectionsName[indexPath.row]
        
        
        
        for i in 1...6 {
            if indexPath.row == 0 {
                let restaurantImage = cell.viewWithTag(i+6) as? UIButton
                let starImage1 = cell.viewWithTag(i*5 + 45) as? UIImageView
                let starImage2 = cell.viewWithTag(i*5 + 46) as? UIImageView
                let starImage3 = cell.viewWithTag(i*5 + 47) as? UIImageView
                let starImage4 = cell.viewWithTag(i*5 + 48) as? UIImageView
                let starImage5 = cell.viewWithTag(i*5 + 49) as? UIImageView
                setRatingImagesByRestaurantRating(image1: starImage1!, image2: starImage2!, image3: starImage3!, image4: starImage4!, image5: starImage5!, restaurant: newRestaurants[newRestaurants.count - i])
                if restaurantImage != nil{
                    restaurantImage!.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                    restaurantImage!.tag = 100 * i + indexPath.row
                    restaurantImage!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
                }
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }else if indexPath.row == 1 {
                let restaurantImage = cell.viewWithTag(i+6) as! UIButton
                let starImage1 = cell.viewWithTag(i*5 + 45) as? UIImageView
                let starImage2 = cell.viewWithTag(i*5 + 46) as? UIImageView
                let starImage3 = cell.viewWithTag(i*5 + 47) as? UIImageView
                let starImage4 = cell.viewWithTag(i*5 + 48) as? UIImageView
                let starImage5 = cell.viewWithTag(i*5 + 49) as? UIImageView
                setRatingImagesByRestaurantRating(image1: starImage1!, image2: starImage2!, image3: starImage3!, image4: starImage4!, image5: starImage5!, restaurant: newRestaurants[newRestaurants.count - i])
                restaurantImage.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }else if indexPath.row == 2 {
                let restaurantImage = cell.viewWithTag(i+6) as? UIButton
                let starImage1 = cell.viewWithTag(i*5 + 45) as? UIImageView
                let starImage2 = cell.viewWithTag(i*5 + 46) as? UIImageView
                let starImage3 = cell.viewWithTag(i*5 + 47) as? UIImageView
                let starImage4 = cell.viewWithTag(i*5 + 48) as? UIImageView
                let starImage5 = cell.viewWithTag(i*5 + 49) as? UIImageView
                setRatingImagesByRestaurantRating(image1: starImage1!, image2: starImage2!, image3: starImage3!, image4: starImage4!, image5: starImage5!, restaurant: randomRestaurants[i - 1])
                if restaurantImage != nil {
                    restaurantImage!.setImage(randomRestaurants[i - 1].images[0], for: .normal)
                    restaurantImage!.tag = 100 * i + indexPath.row
                    restaurantImage!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
                }
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = randomRestaurants[i - 1].name
            }else if indexPath.row == 3 {
                let restaurantImage = cell.viewWithTag(i+6) as? UIButton
                let starImage1 = cell.viewWithTag(i*5 + 45) as? UIImageView
                let starImage2 = cell.viewWithTag(i*5 + 46) as? UIImageView
                let starImage3 = cell.viewWithTag(i*5 + 47) as? UIImageView
                let starImage4 = cell.viewWithTag(i*5 + 48) as? UIImageView
                let starImage5 = cell.viewWithTag(i*5 + 49) as? UIImageView
                setRatingImagesByRestaurantRating(image1: starImage1!, image2: starImage2!, image3: starImage3!, image4: starImage4!, image5: starImage5!, restaurant: mostReviewRestaurants[i - 1])
                if restaurantImage != nil {
                    restaurantImage!.setImage(mostReviewRestaurants[i - 1].images[0], for: .normal)
                    restaurantImage!.tag = 100 * i + indexPath.row
                    restaurantImage!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
                }
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = mostReviewRestaurants[i - 1].name
            }
            
            let forwardArrowButton = cell.viewWithTag(6) as? UIButton
            if forwardArrowButton != nil {
                forwardArrowButton!.tag = indexPath.row
                forwardArrowButton!.addTarget(self, action: #selector(self.ForwardArrowBtnPress(sender:)), for: .touchUpInside)
            }
            
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    @objc func restaurantBtnPress(sender: UIButton){
        if sender.tag == 100 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 1]
        }else if sender.tag == 101 {
            
        } else if sender.tag == 102{
            selectedRestaurant = randomRestaurants[0]
        }else if sender.tag == 103 {
            selectedRestaurant = mostReviewRestaurants[0]
        }else if sender.tag == 200 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 2]
        }else if sender.tag == 201 {
            
        } else if sender.tag == 202{
            selectedRestaurant = randomRestaurants[1]
        }else if sender.tag == 203 {
            selectedRestaurant = mostReviewRestaurants[1]
        }else if sender.tag == 300 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 3]
        }else if sender.tag == 301 {
            
        } else if sender.tag == 302{
            selectedRestaurant = randomRestaurants[2]
        }else if sender.tag == 303 {
            selectedRestaurant = mostReviewRestaurants[2]
        } else if sender.tag == 400 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 4]
        }else if sender.tag == 401 {
            
        } else if sender.tag == 402{
            selectedRestaurant = randomRestaurants[3]
        }else if sender.tag == 403 {
            selectedRestaurant = mostReviewRestaurants[3]
        }else if sender.tag == 500 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 5]
        }else if sender.tag == 501 {
            
        } else if sender.tag == 502{
            selectedRestaurant = randomRestaurants[4]
        }else if sender.tag == 503 {
            selectedRestaurant = mostReviewRestaurants[4]
        }else if sender.tag == 600 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 6]
        }else if sender.tag == 601 {
            
        } else if sender.tag == 602{
            selectedRestaurant = randomRestaurants[5]
        }else if sender.tag == 603 {
            selectedRestaurant = mostReviewRestaurants[5]
        }
        
        performSegue(withIdentifier: "restaurantdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantlist"{
            let seg = segue.destination as! RestaurantListViewController
            seg.type = selectedType
            seg.user = user
            seg.restaurantList = selectedRestaurantList
            seg.selectedRestaurant = newRestaurants[0]
        }
        
        if segue.identifier == "restaurantdetail"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = selectedRestaurant
            seg.user = user
        }
    }
    
    @objc func ForwardArrowBtnPress(sender: UIButton){
        if sender.tag == 0 {
            selectedType = "New Restaurants"
            selectedRestaurantList = newRestaurants
        }else if sender.tag == 1 {
            selectedType = "Top Restaurants"
        }else if sender.tag == 2 {
            selectedType = "Random Restaurants"
            selectedRestaurantList = randomRestaurants
        }else if sender.tag == 3 {
            selectedType = "Most Review"
            selectedRestaurantList = mostReviewRestaurants
        }
        performSegue(withIdentifier: "restaurantlist", sender: self)
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
    
    
    
}
