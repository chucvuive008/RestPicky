//
//  SearchViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var selectedType = ""
    var newRestaurants = [Restaurant]()
    let restaurantCollectionsName = ["New Restaurants", "Top Restaurants", "Random Restaurants", "Most review"]
    @IBOutlet weak var CollectionTableView: UITableView!
    
    @IBOutlet weak var searchField: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchField.backgroundImage = UIImage()
        searchField.layer.borderWidth = 0
        CollectionTableView.delegate = self
        CollectionTableView.dataSource = self
        // Do any additional setup after loading the view.
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantlist"{
            let seg = segue.destination as! RestaurantListViewController
            seg.type = selectedType
        }
    }
    
    @IBAction func SelectRestaurantType(_ sender: UIButton) {
        if sender.tag == 1{
            selectedType = "American"
        } else if sender.tag == 2{
            selectedType = "Japanese"
        } else if sender.tag == 3{
            selectedType = "Seafood"
        }else if sender.tag == 4{
            selectedType = "Italian"
        } else if sender.tag == 5{
            selectedType = "Mexican"
        } else if sender.tag == 6{
            selectedType = "Indian"
        } else if sender.tag == 7{
            selectedType = "Chinese"
        } else if sender.tag == 8{
            selectedType = "Soup"
        } else if sender.tag == 9{
            selectedType = "Steak"
        }
        performSegue(withIdentifier: "restaurantlist", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let collectionName = cell.viewWithTag(1) as! UILabel
        collectionName.text = restaurantCollectionsName[indexPath.row]
        for i in 1...6 {
            if indexPath.row == 0 {
                let restaurantImage = cell.viewWithTag(i+2) as! UIButton
                restaurantImage.setImage(newRestaurants[i-1].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 8) as! UILabel
                restaurantName.text = newRestaurants[i-1].name
            }else if indexPath.row == 1 {
                let restaurantImage = cell.viewWithTag(i+2) as! UIButton
                restaurantImage.setImage(newRestaurants[i-1].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 8) as! UILabel
                restaurantName.text = newRestaurants[i-1].name
            }else if indexPath.row == 2 {
                let restaurantImage = cell.viewWithTag(i+2) as! UIButton
                restaurantImage.setImage(newRestaurants[i-1].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 8) as! UILabel
                restaurantName.text = newRestaurants[i-1].name
            }else if indexPath.row == 3 {
                let restaurantImage = cell.viewWithTag(i+2) as! UIButton
                restaurantImage.setImage(newRestaurants[i-1].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 8) as! UILabel
                restaurantName.text = newRestaurants[i-1].name
            }
        }
        
//        restaurantImage.setImage(image, for: .normal)
        return cell
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
