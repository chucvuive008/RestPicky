//
//  RestaurantDetailViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/30/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    var restaurant = Restaurant()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = restaurant.name
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
