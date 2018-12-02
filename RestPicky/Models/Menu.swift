//
//  Menu.swift
//  RestPicky
//
//  Created by Denys Ponce on 11/1/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import Foundation

public class Menu {
    var uid : String
    var category : String
    var name : String
    var price : Double
    
    
    init() {
        category = ""
        name = ""
        uid = ""
        price = 0
    }
    
    init(uid : String, category : String, name : String, price : Double) {
        self.category = category
        self.name = name
        self.uid = uid
        self.price = price
    }
}
