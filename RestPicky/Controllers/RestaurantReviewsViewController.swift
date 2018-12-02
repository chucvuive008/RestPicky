//
//  RestaurantReviewsViewController.swift
//  RestPicky
//
//  Created by Denys Ponce on 12/2/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantReviewsViewController: UIViewController {

    var restaurant = Restaurant()
    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantName.text = restaurant.name
        var myRaiting = restaurant.review
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBAction func BackToRestaurantDetail(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var restaurantName: UILabel!
    
    @IBOutlet weak var buttonRateStar1: UIButton!
    @IBOutlet weak var buttonRateStar2: UIButton!
    @IBOutlet weak var buttonRateStar3: UIButton!
    @IBOutlet weak var buttonRateStar4: UIButton!
    @IBOutlet weak var buttonRateStar5: UIButton!
    
    @IBAction func setRate1(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
    }
    
    @IBAction func setRate2(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
    }
    
    @IBAction func setRate3(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
    }
    
    @IBAction func setRate4(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
    }
    
    @IBAction func setRate5(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "YellowStarIcon"), for: [])
    }
    
    func paintStars(raiting: Double)
    {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "YellowStarIcon"), for: [])
        
        if raiting < 4.5{
            buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        }
        if raiting < 3.5{
            buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        }
        if raiting < 2.5{
            buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        }
        if raiting < 1.5{
            buttonRateStar2.setImage(UIImage(named: "BlankStarIcon"), for: [])
        }
        if raiting < 0.5{
            buttonRateStar1.setImage(UIImage(named: "BlankStarIcon"), for: [])
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
