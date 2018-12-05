//
//  RestaurantReviewsViewController.swift
//  RestPicky
//
//  Created by Denys Ponce on 12/2/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

class RestaurantReviewsViewController: UIViewController {

    var restaurant = Restaurant()
    var user = User()
    var ref:DatabaseReference?
    var myRating: Double = 0.0
    var myReview = Review()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        restaurantName.text = restaurant.name
        
        populateValuesIfmyReviewExists()
        
        // Do any additional setup after loading the view.
    }
    
    func myReviewExists() -> Bool
    {
        for review in restaurant.review
        {
            if review.userId == user.uid
            {
                myReview = review
                return true
            }
        }
        return false
    }
    
    func getReviewId() -> Int
    {
        var reviewId = 0
        if restaurant.review.last?.id == nil {
            reviewId = 1
        }else {
            if myReviewExists()
            {
                reviewId = myReview.id
            }
            else{
                reviewId = (restaurant.review.last?.id)! + 1
            }
        }
        
        return reviewId
    }
    
    func populateValuesIfmyReviewExists()
    {
        if myReviewExists()
        {
            paintStars(raiting: myReview.rating)
            myReviewBox.text = myReview.comment
            myRating = myReview.rating
        }
    }
    
    @IBAction func postReview(_ sender: Any) {
        let reviewId = getReviewId()
        
        self.ref?.child("restaurant/\(restaurant.id)/review/\(reviewId)").setValue(["comment" : myReviewBox.text, "id" : reviewId, "rating" : myRating, "userId" : user.uid])
        if myReviewExists(){
            restaurant.review[reviewId - 1].comment = myReviewBox.text
            restaurant.review[reviewId - 1].rating = myRating
        }else {
            var review = Review()
            review.id = reviewId
            review.comment = myReviewBox.text
            review.rating = myRating
            review.userId = user.uid
            restaurant.review.append(review)
        }
        ref?.child("Restaurant/\(self.restaurant.id)").observeSingleEvent(of: .value, with: { (snapshot) in
            self.restaurant = snapshot.value as? Restaurant ?? Restaurant()
        })
    }
    
    @IBOutlet weak var myReviewBox: UITextView!
    
    
    @IBAction func BackToRestaurantDetail(_ sender: Any) {
        dismiss(animated: true)
        {
            self.performSegue(withIdentifier: "reviewToDetailSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewToDetailSegue"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = restaurant
            seg.user = user
            print("Here from the review")
        }
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
        
        myRating = 1
    }
    
    @IBAction func setRate2(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        myRating = 2
    }
    
    @IBAction func setRate3(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "BlankStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        myRating = 3
    }
    
    @IBAction func setRate4(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "BlankStarIcon"), for: [])
        
        myRating = 4
    }
    
    @IBAction func setRate5(_ sender: Any) {
        buttonRateStar1.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar2.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar3.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar4.setImage(UIImage(named: "YellowStarIcon"), for: [])
        buttonRateStar5.setImage(UIImage(named: "YellowStarIcon"), for: [])
        
        myRating = 5
    }
    
    func paintStars(raiting: Double)
    {
        print("My raiting is : \(raiting)")
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
