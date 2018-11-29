//
//  Restaurant.swift
//  RestPicky
//
//  Created by Nghia Vuong on 10/25/18.
//  Copyright © 2018 Nghia Vuong. All rights reserved.
//


import UIKit
import Foundation

public class Restaurant {
    var id : Int
    var name : String
    var street : String
    var apt : String?
    var city : String
    var state : String
    var zipcode : Int
    var phoneNumber : String
    var rating : Double
    var latitude : Double
    var longitude: Double
    var type : String
    var images = [UIImage]()
    var review = [Review]()
    
    init() {
        id = 0
        name = ""
        street = ""
        city = ""
        state = ""
        zipcode = 0
        phoneNumber = ""
        rating = 0
        latitude = 0
        longitude = 0
        type = ""
        
    }
    
    init(localId: Int) {
        id = localId
        name = ""
        street = ""
        city = ""
        state = ""
        zipcode = 0
        phoneNumber = ""
        rating = 0
        latitude = 0
        longitude = 0
        type = ""
    }
}
