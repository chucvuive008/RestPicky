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
        print(index)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let restaurantName = cell.viewWithTag(1) as! UILabel
        restaurantName.text = restaurants[index].name
        let rating = cell.viewWithTag(2) as! UILabel
        rating.text = String(restaurants[index].rating)
        var yourReview = ""
        print(restaurants[index].review)
        print(reviewsInt[index])
        
        var review = restaurants[index].review[(reviewsInt[index] - 1)]
            yourReview += review.comment
            print(review.id)
            print(review.rating)
            print(review.userId)

        let reviewLabel = cell.viewWithTag(3) as!UILabel
        reviewLabel.text = yourReview
        
        
        return cell
    }
    
    
}
