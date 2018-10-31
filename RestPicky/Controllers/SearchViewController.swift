//
//  SearchViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 9/29/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref : DatabaseReference?
    var selectedType = ""
    var selectedRestaurant = Restaurant()
    var newRestaurants = [Restaurant]()
    var selectedRestaurantList = [Restaurant]()
    let restaurantCollectionsName = ["New Restaurants", "Top Restaurants", "Random Restaurants", "Most review"]
    @IBOutlet weak var CollectionTableView: UITableView!
    
    @IBOutlet weak var searchField: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchField.backgroundImage = UIImage()
        searchField.layer.borderWidth = 0
        CollectionTableView.delegate = self
        CollectionTableView.dataSource = self
        ref = Database.database().reference()
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
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let collectionName = cell.viewWithTag(5) as! UILabel
        collectionName.text = restaurantCollectionsName[indexPath.row]
        

        
        for i in 1...6 {
            if indexPath.row == 0 {
                let restaurantImage = cell.viewWithTag(i+6) as? UIButton
                if restaurantImage != nil{
                    restaurantImage!.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                    restaurantImage!.tag = 100 * i + indexPath.row
                    restaurantImage!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
                }
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }else if indexPath.row == 1 {
                let restaurantImage = cell.viewWithTag(i+6) as! UIButton
                restaurantImage.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }else if indexPath.row == 2 {
                let restaurantImage = cell.viewWithTag(i+6) as! UIButton
                restaurantImage.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }else if indexPath.row == 3 {
                let restaurantImage = cell.viewWithTag(i+6) as! UIButton
                restaurantImage.setImage(newRestaurants[newRestaurants.count - i].images[0], for: .normal)
                let restaurantName = cell.viewWithTag(i + 12) as! UILabel
                restaurantName.text = newRestaurants[newRestaurants.count - i].name
            }
            
            let forwardArrowButton = cell.viewWithTag(6) as? UIButton
            if forwardArrowButton != nil {
                forwardArrowButton!.tag = indexPath.row
                forwardArrowButton!.addTarget(self, action: #selector(self.ForwardArrowBtnPress(sender:)), for: .touchUpInside)
            }
            
//            let restaurantButton1 = cell.viewWithTag(7) as? UIButton
//            if restaurantButton1 != nil {
//                restaurantButton1!.tag = 100 + indexPath.row
//                restaurantButton1!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
//
//            let restaurantButton2 = cell.viewWithTag(8) as? UIButton
//            if restaurantButton2 != nil {
//                restaurantButton2!.tag = 200 + indexPath.row
//                restaurantButton2!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
//
//            let restaurantButton3 = cell.viewWithTag(9) as? UIButton
//            if restaurantButton3 != nil {
//                restaurantButton3!.tag = 300 + indexPath.row
//                restaurantButton3!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
//
//            let restaurantButton4 = cell.viewWithTag(10) as? UIButton
//            if restaurantButton4 != nil {
//                restaurantButton4!.tag = 400 + indexPath.row
//                restaurantButton4!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
//
//            let restaurantButton5 = cell.viewWithTag(11) as? UIButton
//            if restaurantButton5 != nil {
//                restaurantButton5!.tag = 500 + indexPath.row
//                restaurantButton5!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
//
//            let restaurantButton6 = cell.viewWithTag(12) as? UIButton
//            if restaurantButton6 != nil {
//                restaurantButton6!.tag = 600 + indexPath.row
//                restaurantButton6!.addTarget(self, action: #selector(self.restaurantBtnPress(sender:)), for: .touchUpInside)
//            }
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none 
        return cell
    }
    
    @objc func restaurantBtnPress(sender: UIButton){
        if sender.tag == 100 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 1]
        }else if sender.tag == 101 {
            
        } else if sender.tag == 102{
            
        }else if sender.tag == 103 {
            
        }else if sender.tag == 200 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 2]
        }else if sender.tag == 201 {
            
        } else if sender.tag == 202{
            
        }else if sender.tag == 203 {
            
        }else if sender.tag == 300 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 3]
        }else if sender.tag == 301 {
            
        } else if sender.tag == 302{
            
        }else if sender.tag == 303 {
            
        } else if sender.tag == 400 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 4]
        }else if sender.tag == 401 {
            
        } else if sender.tag == 402{
            
        }else if sender.tag == 403 {
            
        }else if sender.tag == 500 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 5]
        }else if sender.tag == 501 {
            
        } else if sender.tag == 502{
            
        }else if sender.tag == 503 {
            
        }else if sender.tag == 600 {
            selectedRestaurant = newRestaurants[newRestaurants.count - 6]
        }else if sender.tag == 601 {
            
        } else if sender.tag == 602{
            
        }else if sender.tag == 603 {
            
        }
        
        performSegue(withIdentifier: "restaurantdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantlist"{
            let seg = segue.destination as! RestaurantListViewController
            seg.type = selectedType
            seg.restaurantList = selectedRestaurantList
            seg.selectedRestaurant = newRestaurants[0]
        }
        
        if segue.identifier == "restaurantdetail"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = selectedRestaurant
        }
    }
    
    @objc func ForwardArrowBtnPress(sender: UIButton){
        if sender.tag == 0 {
            selectedType = "New Restaurants"
            selectedRestaurantList = newRestaurants
        }else if sender.tag == 1 {
            selectedType = "Top Restaurants"
        }else if sender.tag == 2 {
            selectedType = "Random Restaurants"
        }else if sender.tag == 3 {
            selectedType = "Most Review"
        }
        performSegue(withIdentifier: "restaurantlist", sender: self)
    }

    func getPhoto (urlString : String, restaurant: Restaurant){
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                if data != nil{
                    restaurant.images.append(UIImage(data: data!)!)
                }
            }
        }).resume()
    }
    
   
    
    
}
