//
//  ReviewsViewController.swift
//  RestPicky
//
//  Created by user145117 on 11/1/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase





class ReviewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var reviewsTableView: UITableView!
    var restaurants = [Restaurant]()
    var reviewsInt = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.reloadData()
        print(restaurants)
        print(reviewsInt)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
//        print(index)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let restaurantName = cell.viewWithTag(1) as! UILabel
        restaurantName.text = restaurants[index].name
//        print(restaurants[index].review)
//        print(reviewsInt[index])
        var yourReview = ""
        var yourRating = 0.0
        var review = restaurants[index].review[(reviewsInt[index] - 1)]
            yourReview += review.comment
//            print(review.id)
        yourRating = review.rating
//            print(review.userId)

        let reviewLabel = cell.viewWithTag(3) as!UILabel
        reviewLabel.text = yourReview
        
        let restaurantImage = cell.viewWithTag(4) as! UIImageView
        restaurantImage.image = restaurants[index].images[0]
        return cell
        
        let starImage1 = cell.viewWithTag(50) as! UIImageView
        let starImage2 = cell.viewWithTag(51) as! UIImageView
        let starImage3 = cell.viewWithTag(52) as! UIImageView
        let starImage4 = cell.viewWithTag(53) as! UIImageView
        let starImage5 = cell.viewWithTag(54) as! UIImageView
        
        setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, userRating: CGFloat(yourRating))
        
    }
    
    func setRatingImagesByRestaurantRating(image1: UIImageView, image2: UIImageView, image3: UIImageView, image4: UIImageView, image5: UIImageView, userRating: CGFloat){
        
        if userRating < 0.5{
            image1.image = UIImage(named: "BlankStarIcon")
            image2.image = UIImage(named: "BlankStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if userRating >= 0.5 && userRating < 1.5{
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "BlankStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if userRating >= 1.5 && userRating < 2.5 {
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "BlankStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if userRating >= 2.5 && userRating < 3.5{
            image1.image = UIImage(named: "YellowStarIcon")
            image2.image = UIImage(named: "YellowStarIcon")
            image3.image = UIImage(named: "YellowStarIcon")
            image4.image = UIImage(named: "BlankStarIcon")
            image5.image = UIImage(named: "BlankStarIcon")
        } else if userRating >= 3.5 && userRating < 4.5 {
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
