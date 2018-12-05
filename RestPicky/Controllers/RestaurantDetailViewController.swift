//
//  RestaurantDetailViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import MapKit

protocol updateRestaurantsDelegate{
    func updatedRestaurant(restaurant: Restaurant)
}

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var updateDelegate : updateRestaurantsDelegate?
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(restaurantMenu.count)
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // set the text from the data model
        let menuItem = cell.viewWithTag(1000) as! UILabel
        let price = cell.viewWithTag(1001) as! UILabel
        
        menuItem.text = restaurantMenu[indexPath.row].name
        price.text = "$\(restaurantMenu[indexPath.row].price)"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        paintStars(raiting: getRestaurnatRaiting())
        numberReviews.text = "\(restaurant.review.count)"
    }
    
    var reviews = 0 //Should be restaurant.reviews
    var myRating = 0 //Should be userrestaurant.raiting
    var restaurant = Restaurant()
    var user = User()
    var total = 0.0
    var restaurantMenu = [Menu]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantMenu.append(Menu(uid: "1", category: "Entry", name: "Calamary Fried", price: 5.99))
        restaurantMenu.append(Menu(uid: "2", category: "Entry", name: "Fish Taco Bits", price: 7.99))
        restaurantMenu.append(Menu(uid: "3", category: "Entry", name: "Coconut Shrimp", price: 8.99))
        restaurantMenu.append(Menu(uid: "4", category: "Entry", name: "Shrimp Coctail", price: 9.99))
        restaurantMenu.append(Menu(uid: "5", category: "Entry", name: "Fish Especial Soup", price: 6.99))
        
        titleLabel.text = restaurant.name
        Street.text = restaurant.street
        cityStateZip.text = restaurant.city + ", " + restaurant.state + " \(restaurant.zipcode)"
        restaurantImage.image = restaurant.images[0]
        
        numberReviews.text = "\(restaurant.review.count)"
        paintStars(raiting: getRestaurnatRaiting())
        phoneNumber.setTitle("Call (\(restaurant.phoneNumber))", for: [])
    }
    
    
    
    @IBOutlet weak var numberReviews: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    
    @IBOutlet weak var phoneNumber: UIButton!
    
    @IBAction func buttonMyRating(_ sender: Any) {
        performSegue(withIdentifier: "restaurantRatingSegue", sender: self)
    }
    
    
    @IBAction func buttonCall(_ sender: Any) {
        if let url = URL(string: "tel://\(restaurant.phoneNumber)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func buttonGetDirections(_ sender: Any) {
        let lat1 : NSString = NSString(format:"%f", restaurant.latitude)
        let lng1 : NSString = NSString(format:"%f", restaurant.longitude)
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "\(restaurant.name)"
        mapItem.openInMaps(launchOptions: options)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "restaurantRatingSegue"{
            let seg = segue.destination as! RestaurantReviewsViewController
            seg.restaurant = restaurant
            seg.user = user
        }
    }
    
    //        rate(myRate: 1)
    
    @IBAction func backBtnPress(_ sender: Any) {
        updateDelegate?.updatedRestaurant(restaurant: restaurant)
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
    
    func getRestaurnatRaiting() -> Double
    {
        var totalRating : Double = 0
        for review in restaurant.review{
            totalRating += review.rating
        }
        var averageRating = 0.0
        
        if restaurant.review.count != 0{
            averageRating = totalRating/Double(restaurant.review.count)
        }
        
        return averageRating
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
