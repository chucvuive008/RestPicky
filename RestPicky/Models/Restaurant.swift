//
//  Restaurant.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//

import Foundation

public class Restaurant {
    var id : Int
    var name : String
    var street : String
    var apt : String?
    var city : String
    var state : String
    var zipcode : Int
    var image : String?
    var phoneNumber : Int
    var rating : Double
    
    init() {
        id = 0
        name = ""
        street = ""
        city = ""
        state = ""
        zipcode = 0
        phoneNumber = 0
        rating = 0
    }
}
