//
//  RestaurantDetailViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = restaurant.name
        Street.text = restaurant.street + "123 Main St." 
        cityStateZip.text = restaurant.city + ", " + restaurant.state + " \(restaurant.zipcode)"
        restaurantImage.image = restaurant.images[0]
        
        paintStars()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    
    @IBOutlet weak var Street: UILabel!
    
    @IBOutlet weak var cityStateZip: UILabel!
    
    func paintStars()
    {
        star1.image = UIImage(named: "YellowStarIcon")
        star2.image = UIImage(named: "YellowStarIcon")
        star3.image = UIImage(named: "YellowStarIcon")
        star4.image = UIImage(named: "YellowStarIcon")
        star5.image = UIImage(named: "YellowStarIcon")
        var raiting = restaurant.rating
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
