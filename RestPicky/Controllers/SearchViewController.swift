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
    var americanRestaurants = [Restaurant]()
    var italianRestaurants = [Restaurant]()
    var japaneseRestaurants = [Restaurant]()
    var seafoodRestaurants = [Restaurant]()
    var mexicoRestaurants = [Restaurant]()
    var indianRestaurants = [Restaurant]()
    var chineseRestaurants = [Restaurant]()
    var soupRestaurants = [Restaurant]()
    var steakRestaurants = [Restaurant]()
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
        getAmericanRestaurants(type: "American")
        getItalianRestaurants(type: "Italian")
        getJapaneseRestaurants(type: "Japanese")
        getSeafoodRestaurants(type: "Seafood")
        getMexicanRestaurants(type: "Mexican")
        getIndianRestaurants(type: "Indian")
        getChineseRestaurants(type: "Chinese")
        getSoupRestaurants(type: "Soup")
        getSteakRestaurants(type: "Steak")
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
    
    func getAmericanRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.americanRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.americanRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.americanRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.americanRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.americanRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.americanRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.americanRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.americanRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.americanRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.americanRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.americanRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.americanRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getItalianRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.italianRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.italianRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.italianRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.italianRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.italianRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.italianRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.italianRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.italianRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.italianRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.italianRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.italianRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.italianRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getJapaneseRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.japaneseRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.japaneseRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.japaneseRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.japaneseRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.japaneseRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.japaneseRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.japaneseRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.japaneseRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.japaneseRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.japaneseRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.japaneseRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.japaneseRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getSeafoodRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.seafoodRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.seafoodRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.seafoodRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.seafoodRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.seafoodRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.seafoodRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.seafoodRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.seafoodRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.seafoodRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.seafoodRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.seafoodRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.seafoodRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getMexicanRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.mexicoRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.mexicoRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.mexicoRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.mexicoRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.mexicoRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.mexicoRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.mexicoRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.mexicoRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.mexicoRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.mexicoRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.mexicoRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.mexicoRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getIndianRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.indianRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.indianRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.indianRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.indianRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.indianRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.indianRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.indianRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.indianRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.indianRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.indianRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.indianRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.indianRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getChineseRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.chineseRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.chineseRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.chineseRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.chineseRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.chineseRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.chineseRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.chineseRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.chineseRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.chineseRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.chineseRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.chineseRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.chineseRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getSoupRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.soupRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.soupRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.soupRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.soupRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.soupRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.soupRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.soupRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.soupRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.soupRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.soupRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.soupRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.soupRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    func getSteakRestaurants(type: String){
        ref?.child("restaurant").queryOrdered(byChild: "type").queryEqual(toValue: type).observeSingleEvent(of: .value, with: { (snapshot) in
            if let restaurantList = snapshot.value as? NSDictionary{
                for restaurant in restaurantList {
                    
                    let key = restaurant.key as! String
                    self.steakRestaurants.append(Restaurant(localId: Int(key)!))
                    let children = restaurant.value as! NSDictionary
                    for child in children{
                        if child.key as! String == "images"{
                            
                            if let childSnapshot = snapshot.childSnapshot(forPath: "\(key)/images").value{
                                print((childSnapshot as AnyObject).count!)
                                for index in 1..<(childSnapshot as AnyObject).count!{
                                    
                                    self.getPhoto(urlString: "https://firebasestorage.googleapis.com/v0/b/restpicky-39f7d.appspot.com/o/rest%2F\(self.steakRestaurants.last!.id)%2F\(index).jpg?alt=media&token=6cb93cf1-69eb-439d-80f3-ae0e622e1f51", restaurant: self.steakRestaurants.last!)
                                }
                            }
                        }else if child.key as! String == "street"{
                            self.steakRestaurants.last!.street = child.value as! String
                        }else if child.key as! String == "city"{
                            self.steakRestaurants.last!.city = child.value as! String
                        }else if child.key as! String == "state"{
                            self.steakRestaurants.last!.state = child.value as!  String
                        }else if child.key as! String == "latitude"{
                            self.steakRestaurants.last!.latitude = child.value as! Double
                        }else if child.key as! String == "longitude"{
                            self.steakRestaurants.last!.longitude = child.value as! Double
                        }else if child.key as! String == "name"{
                            self.steakRestaurants.last!.name = child.value as! String
                        }else if child.key as! String == "phone"{
                            self.steakRestaurants.last!.phoneNumber = child.value as! String
                        }else if child.key as! String == "zipcode"{
                            self.steakRestaurants.last!.zipcode = child.value as! Int
                        }else if child.key as! String == "type"{
                            self.steakRestaurants.last!.type = child.value as! String
                        }
                    }
                    
                }
            }
        })
    }
    
    @IBAction func SelectRestaurantType(_ sender: UIButton) {
        if sender.tag == 1{
            selectedType = "American"
            selectedRestaurantList = americanRestaurants
        } else if sender.tag == 2{
            selectedType = "Japanese"
            selectedRestaurantList = japaneseRestaurants
        } else if sender.tag == 3{
            selectedType = "Seafood"
            selectedRestaurantList = seafoodRestaurants
        }else if sender.tag == 4{
            selectedType = "Italian"
            selectedRestaurantList = italianRestaurants
        } else if sender.tag == 5{
            selectedType = "Mexican"
            selectedRestaurantList = mexicoRestaurants
        } else if sender.tag == 6{
            selectedType = "Indian"
            selectedRestaurantList = indianRestaurants
        } else if sender.tag == 7{
            selectedType = "Chinese"
            selectedRestaurantList = chineseRestaurants
        } else if sender.tag == 8{
            selectedType = "Soup"
            selectedRestaurantList = soupRestaurants
        } else if sender.tag == 9{
            selectedType = "Steak"
            selectedRestaurantList = steakRestaurants
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
