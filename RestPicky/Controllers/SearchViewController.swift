//
//  SearchViewController.swift
//  RestPicky
//
//  Created by Nghia Vuong on 11/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.layer.borderWidth = 0
        searchBar.layer.cornerRadius = 10
        searchBar.layer.masksToBounds = true
        // Do any additional setup after loading the view.
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
