//
//  RestaurantListViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var restaurant = Restaurant()
    @IBOutlet weak var restaurantsTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var type = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = type
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "restaurantdetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantdetail"{
            let seg = segue.destination as! RestaurantDetailViewController
            seg.restaurant = restaurant
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
