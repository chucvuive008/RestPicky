//
//  RestaurantDetailViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let itemList = ["Calamary Fried", "Fish Taco Bits", "Coconut Shrimp", "Shrimp Coctail"]
    
    let priceList = ["$5.99", "$5.99", "$5.99", "$5.99"]
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(itemList.count)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // set the text from the data model
        let menuItem = cell.viewWithTag(1000) as! UILabel
        let price = cell.viewWithTag(1001) as! UILabel
        
        menuItem.text = itemList[indexPath.row]
        price.text = priceList[indexPath.row]
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    

    var reviews = 0 //Should be restaurant.reviews
    var myRating = 0 //Should be userrestaurant.raiting
    
    var restaurant = Restaurant()
    var total = 0.0
    var restaurantMenu = ["Calamary Fried": "$5.99",
                          "Fish Taco Bits": "$5.99",
                          "Coconut Shrimp": "$5.99",
                          "Shrimp Coctail": "$5.99",] as [AnyHashable : String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        total = restaurant.rating * Double(reviews)
        
        titleLabel.text = restaurant.name
        Street.text = restaurant.street
        cityStateZip.text = restaurant.city + ", " + restaurant.state + " \(restaurant.zipcode)"
        restaurantImage.image = restaurant.images[0]
        
        numberReviews.text = "\(reviews)"
        paintStars(raiting: restaurant.rating)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var numberReviews: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBOutlet weak var buttonRateStar5: UIButton!
    @IBOutlet weak var buttonRateStar4: UIButton!
    @IBOutlet weak var buttonRateStar3: UIButton!
    @IBOutlet weak var buttonRateStar2: UIButton!
    @IBOutlet weak var buttonRateStar1: UIButton!
    
    
    
    @IBAction func rateStar5(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "YellowStarIcon"), for: [])
        
        rate(myRate: 5)
    }
    
    @IBAction func rateStar4(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        rate(myRate: 4)
    }
    
    @IBAction func rateStar3(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        rate(myRate: 3)
    }
    
    @IBAction func rateStar2(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        rate(myRate: 2)
    }
    
    @IBAction func rateStar1(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        rate(myRate: 1)
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var Street: UILabel!
    
    @IBOutlet weak var cityStateZip: UILabel!
    
    func rate(myRate: Int)
    {
        if myRating > 0
        {
            reviews -= 1
            total -= Double(myRating)
        }
        myRating = myRate
        reviews += 1
        total += Double(myRate)
        numberReviews.text = "\(reviews)"
        paintStars(raiting: total / Double(reviews))
    }
    
    func paintStars(raiting: Double)
    {
        star1.image = UIImage(named: "YellowStarIcon")
        star2.image = UIImage(named: "YellowStarIcon")
        star3.image = UIImage(named: "YellowStarIcon")
        star4.image = UIImage(named: "YellowStarIcon")
        star5.image = UIImage(named: "YellowStarIcon")
        
        if raiting < 4.5{
            star5.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 3.5{
            star4.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 2.5{
            star3.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 1.5{
            star2.image = UIImage(named: "BlankStarIcon")
        }
        if raiting < 0.5{
            star1.image = UIImage(named: "BlankStarIcon")
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
