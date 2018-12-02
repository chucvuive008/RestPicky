//
//  RestaurantListViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var restaurantList = [Restaurant]()
    var selectedRestaurant = Restaurant()
    var user = User()
    
    @IBOutlet weak var restaurantsTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = type
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let name = cell.viewWithTag(100) as! UILabel
        let address = cell.viewWithTag(101) as! UILabel
        let phone = cell.viewWithTag(102) as! UILabel
        let image = cell.viewWithTag(103) as! UIImageView
        let heatImage = cell.viewWithTag(104) as! UIImageView
        let starImage1 = cell.viewWithTag(50) as! UIImageView
        let starImage2 = cell.viewWithTag(51) as! UIImageView
        let starImage3 = cell.viewWithTag(52) as! UIImageView
        let starImage4 = cell.viewWithTag(53) as! UIImageView
        let starImage5 = cell.viewWithTag(54) as! UIImageView
        if type == "New Restaurants"{
            setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, restaurant: restaurantList[restaurantList.count - indexPath.row - 1])
            setBookMarkImage(heartImage: heatImage, user: user, restaurantId: restaurantList[restaurantList.count - indexPath.row - 1].id)
            name.text = restaurantList[restaurantList.count - indexPath.row - 1].name
            address.text = restaurantList[restaurantList.count - indexPath.row - 1].street + ", " + restaurantList[restaurantList.count - indexPath.row - 1].city + ", " + restaurantList[restaurantList.count - indexPath.row - 1].state + ", \(restaurantList[restaurantList.count - indexPath.row - 1].zipcode)"
            phone.text = restaurantList[restaurantList.count - indexPath.row - 1].phoneNumber
            image.image = restaurantList[restaurantList.count - indexPath.row - 1].images[0]
        }else{
            setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, restaurant: restaurantList[indexPath.row])
            setBookMarkImage(heartImage: heatImage, user: user, restaurantId: restaurantList[indexPath.row].id)
            name.text = restaurantList[indexPath.row].name
            address.text = restaurantList[indexPath.row].street + ", " + restaurantList[indexPath.row].city + ", " + restaurantList[indexPath.row].state + ", \(restaurantList[indexPath.row].zipcode)"
            phone.text = restaurantList[indexPath.row].phoneNumber
            image.image = restaurantList[indexPath.row].images[0]
        }
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
            seg.user = user
        }
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
    
    func setBookMarkImage(heartImage : UIImageView, user : User, restaurantId : Int){
        if user.restaurantsIdBookmark.contains(restaurantId)
        {
            heartImage.image = UIImage(named: "HeartIcon")
        }else{
            heartImage.image = UIImage(named: "heart")
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
