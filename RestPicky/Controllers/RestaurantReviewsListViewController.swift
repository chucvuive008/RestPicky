//
//  RestaurantReviewsListViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 12/5/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantReviewsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var restaurant = Restaurant()

    @IBOutlet weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurant.review.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // set the text from the data model
        let userName = cell.viewWithTag(2) as! UILabel
        let comment = cell.viewWithTag(8) as! UILabel
        let starImage1 = cell.viewWithTag(3) as! UIImageView
        let starImage2 = cell.viewWithTag(4) as! UIImageView
        let starImage3 = cell.viewWithTag(5) as! UIImageView
        let starImage4 = cell.viewWithTag(6) as! UIImageView
        let starImage5 = cell.viewWithTag(7) as! UIImageView
        
        setRatingImagesByRestaurantRating(image1: starImage1, image2: starImage2, image3: starImage3, image4: starImage4, image5: starImage5, review: restaurant.review[indexPath.row])
        
        userName.text = restaurant.review[indexPath.row].userId
        comment.text = restaurant.review[indexPath.row].comment
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func setRatingImagesByRestaurantRating(image1: UIImageView, image2: UIImageView, image3: UIImageView, image4: UIImageView, image5: UIImageView, review: Review){
        
        let rating = review.rating
        
        image1.image = UIImage(named: "YellowStarIcon")
        image2.image = UIImage(named: "YellowStarIcon")
        image3.image = UIImage(named: "YellowStarIcon")
        image4.image = UIImage(named: "YellowStarIcon")
        image5.image = UIImage(named: "YellowStarIcon")
        
        if rating < 4.5{
            image5.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 3.5{
            image4.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 2.5{
            image3.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 1.5{
            image2.image = UIImage(named: "BlankStarIcon")
        }
        if rating < 0.5{
            image1.image = UIImage(named: "BlankStarIcon")
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
